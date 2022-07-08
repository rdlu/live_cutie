defmodule LiveCutieWeb.MonstersLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Monsters

  @permitted_sort_bys ~w(national_id name types)
  @permitted_sort_orders ~w(asc desc)
  @per_page_default 10

  def mount(_params, _session, socket) do
    monsters = Monsters.list_monsters()

    socket = assign(socket, monsters: monsters)

    {:ok, socket, temporary_assigns: [monsters: []]}
  end

  def handle_params(params, _url, socket) do
    page = param_to_integer(params["page"], 1)
    per_page = param_to_integer(params["per_page"], @per_page_default)

    sort_by =
      params
      |> param_or_first_permitted("sort_by", @permitted_sort_bys)
      |> String.to_atom()

    sort_order =
      params
      |> param_or_first_permitted("sort_order", @permitted_sort_orders)
      |> String.to_atom()

    paginate_options = %{page: page, per_page: per_page}
    sort_options = %{sort_by: sort_by, sort_order: sort_order}

    monsters = Monsters.list_monsters(paginate: paginate_options, sort: sort_options)

    socket =
      assign(socket,
        options: Map.merge(paginate_options, sort_options),
        monsters: monsters
      )

    {:noreply, socket}
  end

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = param_to_integer(per_page, @per_page_default)

    socket =
      push_patch(socket,
        to:
          Routes.live_path(
            socket,
            __MODULE__,
            page: socket.assigns.options.page,
            per_page: per_page,
            sort_by: socket.assigns.options.sort_by,
            sort_order: socket.assigns.options.sort_order
          )
      )

    {:noreply, socket}
  end

  defp pagination_link(socket, text, page, options, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          sort_order: options.sort_order,
          sort_by: options.sort_by,
          page: page,
          per_page: options.per_page
        ),
      class:
        "#{class} hover:bg-slate-300 -ml-px inline-flex items-center px-3 py-2 border border-slate-300 bg-white text-base leading-5 font-medium text-slate-600 no-underline"
    )
  end

  defp sort_link(socket, text, sort_by, options) do
    text =
      if sort_by == options.sort_by do
        text <> emoji(options.sort_order)
      else
        text
      end

    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          sort_order: toggle_sort_order(options.sort_order),
          sort_by: sort_by,
          page: options.page,
          per_page: options.per_page
        ),
      class: "no-underline text-white"
    )
  end

  defp toggle_sort_order(:asc), do: :desc
  defp toggle_sort_order(:desc), do: :asc

  defp emoji(:asc), do: " ⮯"
  defp emoji(:desc), do: " ⮭"

  defp param_or_first_permitted(params, key, permitted) do
    value = params[key]
    if value in permitted, do: value, else: hd(permitted)
  end

  defp param_to_integer(nil, default_value), do: default_value

  defp param_to_integer(param, default_value) do
    case Integer.parse(param) do
      {number, _} ->
        number

      :error ->
        default_value
    end
  end
end
