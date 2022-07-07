defmodule LiveCutieWeb.MonstersLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Monsters

  def mount(_params, _session, socket) do
    monsters = Monsters.list_monsters()

    socket =
      assign(socket,
        monsters: monsters
      )

    {:noreply, socket}

    {:ok, socket, temporary_assigns: [monsters: []]}
  end

  def handle_params(params, _url, socket) do
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "10")
    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()

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
    per_page = String.to_integer(per_page)

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
end
