defmodule LiveCutieWeb.ScrollLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Monsters

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(page: 1, per_page: 20)
      |> load_monsters()

    {:ok, socket, temporary_assigns: [monsters: []]}
  end

  defp load_monsters(socket) do
    :timer.sleep(:timer.seconds(2))
    paginate_options = %{page: socket.assigns.page, per_page: socket.assigns.per_page}
    sort_options = %{sort_by: :national_id, sort_order: :asc}

    monsters = Monsters.list_monsters(paginate: paginate_options, sort: sort_options)

    assign(socket, monsters: monsters)
  end

  def handle_event("load-more", _, socket) do
    socket =
      socket
      |> update(:page, &(&1 + 1))
      |> load_monsters()

    {:noreply, socket}
  end
end
