defmodule LiveCutieWeb.DashLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Dash

  def mount(_params, _session, socket) do
    socket = socket |> assign_stats() |> assign(refresh: 1)

    if connected?(socket), do: schedule_refresh(socket)
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
      <div class="controls flex items-center justify-end">
        <form phx-change="refresh-timer" class="flex items-center">
          <label
            for="refresh"
            class="uppercase tracking-wide text-indigo-800 text-xs font-semibold mr-2"
          >
            Refresh every:
          </label>
          <select
            name="refresh"
            class="focus:outline-none bg-white border-indigo-500 appearance-none bg-slate-200 border-indigo-300 border text-indigo-700 py-2 px-4 rounded-lg leading-tight font-semibold cursor-pointer mr-2 h-10"
          >
            <%= options_for_select(refresh_options(), @refresh) %>
          </select>
        </form>

        <button
          phx-click="refresh"
          class="inline-flex items-center px-4 py-2 border border-indigo-300 text-sm shadow-sm leading-6 font-medium rounded-md text-indigo-700 bg-indigo-100 transition ease-in-out duration-150 outline-none active:bg-indigo-200 hover:bg-white"
        >
          <img src="images/sync-solid.svg" class="mr-2 h-4 w-4" /> Refresh
        </button>
      </div>
    </div>
    """
  end

  def handle_event("refresh", _, socket) do
    socket = socket |> assign_stats() |> schedule_refresh()
    {:noreply, socket}
  end

  def handle_event("refresh-timer", %{"refresh" => refresh}, socket) do
    refresh = String.to_integer(refresh)
    socket = assign(socket, refresh: refresh)
    {:noreply, socket}
  end

  def handle_info(:self_refresh, socket) do
    socket = socket |> assign_stats() |> schedule_refresh()
    {:noreply, socket}
  end

  defp assign_stats(socket) do
    assign(socket, lumens: Dash.lumens(), temperature: Dash.temperature(), co2: Dash.co2())
  end

  defp refresh_options do
    [{"1s", 1}, {"5s", 5}, {"15s", 15}, {"30s", 30}, {"60s", 60}]
  end

  defp schedule_refresh(socket) do
    Process.send_after(self(), :self_refresh, socket.assigns.refresh * 1000)
    socket
  end
end
