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

    paginate_options = %{page: page, per_page: per_page}

    monsters = Monsters.list_monsters(paginate: paginate_options)

    socket =
      assign(socket,
        options: paginate_options,
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
            per_page: per_page
          )
      )

    {:noreply, socket}
  end

  defp pagination_link(socket, text, page, per_page, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          __MODULE__,
          page: page,
          per_page: per_page
        ),
      class:
        "#{class} hover:bg-slate-300 -ml-px inline-flex items-center px-3 py-2 border border-slate-300 bg-white text-base leading-5 font-medium text-slate-600 no-underline"
    )
  end
end
