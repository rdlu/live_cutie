defmodule LiveCutieWeb.SearchLive do
  use LiveCutieWeb, :live_view
  alias LiveCutie.Repositories.Places

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        places: [],
        loading: false,
        search_complete: false
      )

    {:ok, socket}
  end

  def handle_event("zip-search", %{"zip" => zip}, socket) do
    send(self(), {:run_search, zip})

    socket = assign(socket, zip: zip, places: [], loading: true, search_complete: false)

    {:noreply, socket}
  end

  def handle_info({:run_search, zip}, socket) do
    socket =
      case Places.search_by_zip(zip) do
        [] ->
          socket
          |> assign(places: [], loading: false, search_complete: true)

        places ->
          socket |> clear_flash |> assign(places: places, loading: false, search_complete: true)
      end

    {:noreply, socket}
  end
end
