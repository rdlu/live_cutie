defmodule LiveCutieWeb.AutocompleteLive do
  use LiveCutieWeb, :live_view
  alias LiveCutie.Repositories.Places
  alias LiveCutie.Repositories.Cities

  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        zip: "",
        city: "",
        places: [],
        cities: [],
        loading: false,
        search_complete: false
      )

    {:ok, socket}
  end

  def handle_event("search-by-zip", %{"zip" => zip}, socket) do
    send(self(), {:run_search, zip})

    socket = assign(socket, zip: zip, places: [], loading: true, search_complete: false)
    {:ok, socket}
    {:noreply, socket}
  end

  def handle_event("search-by-city", %{"city" => city}, socket) do
    send(self(), {:run_city_search, city})

    socket = assign(socket, city: city, cities: [], loading: true, search_complete: false)

    {:noreply, socket}
  end

  def handle_event("suggest-city", %{"city" => prefix}, socket) do
    socket = assign(socket, cities: Cities.suggest(prefix), city: prefix)
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

  def handle_info({:run_city_search, city}, socket) do
    case Places.search_by_city(city) do
      [] ->
        socket =
          socket
          |> assign(places: [], loading: false, search_complete: true)

        {:noreply, socket}

      places ->
        socket = assign(socket, places: places, loading: false, search_complete: true)
        {:noreply, socket}
    end
  end
end
