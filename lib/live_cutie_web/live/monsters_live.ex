defmodule LiveCutieWeb.MonstersLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Monsters
  alias LiveCutieWeb.Components.Pagination
  alias LiveCutieWeb.Components.PerPage
  alias LiveCutieWeb.ParamParser

  @permitted_sort_bys ~w(national_id name types)
  @permitted_sort_orders ~w(asc desc)
  @per_page_default 10

  def mount(_params, _session, socket) do
    {:ok, socket, temporary_assigns: [monsters: []]}
  end

  def handle_params(params, _url, socket) do
    page = ParamParser.param_to_integer(params["page"], 1)
    per_page = ParamParser.param_to_integer(params["per_page"], @per_page_default)

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
        pagination: Map.merge(paginate_options, sort_options),
        monsters: monsters
      )

    {:noreply, socket}
  end

  def handle_info({PerPage, :changed, per_page}, socket) do
    current_pagination = socket.assigns.pagination
    paginate_options = %{page: current_pagination.page, per_page: per_page}

    sort_options = %{
      sort_by: current_pagination.sort_by,
      sort_order: current_pagination.sort_order
    }

    monsters = Monsters.list_monsters(paginate: paginate_options, sort: sort_options)

    socket =
      assign(socket,
        pagination: Map.merge(current_pagination, paginate_options),
        monsters: monsters
      )

    {:noreply, socket}
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
end
