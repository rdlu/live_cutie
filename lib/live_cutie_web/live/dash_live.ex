defmodule LiveCutieWeb.DashLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Dash

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(2000, self(), :self_refresh)
    end

    socket = assign_stats(socket)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Main Dashboard</h1>
    <div id="dashboard" class="max-w-2xl mx-auto">
      <div class="stats mb-8 rounded-lg bg-white shadow-lg grid grid-cols-3">
        <div class="stat p-6 text-center">
          <span class="value block text-5xl leading-none font-extrabold text-indigo-600">
            <%= @temperature %>°C
          </span>
          <span class="name block mt-2 text-lg leading-6 font-medium text-slate-500">
            Temperature
          </span>
        </div>
        <div class="stat p-6 text-center">
          <span class="value block text-5xl leading-none font-extrabold text-indigo-600">
            <%= @lumens %>
          </span>
          <span class="name block mt-2 text-lg leading-6 font-medium text-slate-500">
            Lumens
          </span>
        </div>
        <div class="stat p-6 text-center">
          <span class="value  block text-5xl leading-none font-extrabold text-indigo-600">
            <%= @co2 %>
          </span>
          <span class="name block mt-2 text-lg leading-6 font-medium text-slate-500">
            CO² (ppm)
          </span>
        </div>
      </div>
      <button
        phx-click="refresh"
        class="inline-flex items-center px-4 py-2 border border-indigo-300 text-sm shadow-sm leading-6 font-medium rounded-md text-indigo-700 bg-indigo-100 transition ease-in-out duration-150 outline-none active:bg-indigo-200 hover:bg-white">
        <img src="images/sync-solid.svg" class="mr-2 h-4 w-4" /> Refresh
      </button>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  def handle_info(:self_refresh, socket) do
    socket = assign_stats(socket)
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket, lumens: Dash.lumens(), temperature: Dash.temperature(), co2: Dash.co2())
  end
end
