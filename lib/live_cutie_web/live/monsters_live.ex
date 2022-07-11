defmodule LiveCutieWeb.MonstersLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Monsters
  alias LiveCutieWeb.Components.Pagination
  alias LiveCutieWeb.Components.PerPage
  alias LiveCutieWeb.ParamParser

  @permitted_sorts ~W(national_id name types)a
  @permitted_orders ~W(asc desc)a
  @per_page_default 10

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign_pagination(
        1,
        @per_page_default,
        hd(@permitted_sorts),
        hd(@permitted_orders)
      )

    {:ok, socket, temporary_assigns: [monsters: []]}
  end

  def handle_params(params, _url, socket) do
    page = ParamParser.param_to_integer(params["page"], 1)
    per_page = ParamParser.param_to_integer(params["per_page"], @per_page_default)

    sort =
      params
      |> param_or_first_permitted("sort", @permitted_sorts)

    order =
      params
      |> param_or_first_permitted("order", @permitted_orders)

    socket =
      socket
      |> assign_pagination(page, per_page, sort, order)
      |> load_monsters()

    {:noreply, socket}
  end

  def handle_info({PerPage, :changed, per_page}, socket) do
    current_pagination = socket.assigns.pagination
    page = current_pagination.page
    sort = current_pagination.sort
    order = current_pagination.order

    socket =
      socket
      |> assign_pagination(page, per_page, sort, order)
      |> load_monsters()

    {:noreply, socket}
  end

  defp assign_pagination(socket, page, per_page, sort, order) do
    socket
    |> assign(pagination: %{page: page, per_page: per_page, sort: sort, order: order})
  end

  defp load_monsters(socket) do
    current_pagination = socket.assigns.pagination

    paginate_options = Map.take(current_pagination, ~w(page per_page)a)

    sort_options = %{
      sort_by: current_pagination.sort,
      sort_order: current_pagination.order
    }

    IO.inspect(socket)

    monsters = Monsters.list_monsters(paginate: paginate_options, sort: sort_options)

    assign(socket, monsters: monsters)
  end

  defp sort_link(socket, text, sort_by, options) do
    text =
      if sort_by == options.sort do
        text <> emoji(options.order)
      else
        text
      end

    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          order: toggle_order(options.order),
          sort: sort_by,
          page: options.page,
          per_page: options.per_page
        ),
      class: "no-underline text-white"
    )
  end

  defp toggle_order(:asc), do: :desc
  defp toggle_order(:desc), do: :asc

  defp emoji(:asc), do: " ⮯"
  defp emoji(:desc), do: " ⮭"

  defp param_or_first_permitted(params, key, permitted) do
    value = params[key] |> to_atom()
    if value in permitted, do: value, else: hd(permitted)
  end

  defp to_atom(nil), do: ""
  defp to_atom(key), do: String.to_atom(key)
end
