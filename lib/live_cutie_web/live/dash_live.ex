defmodule LiveCutieWeb.DashLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Dash

  def mount(_params, _session, socket) do
    socket = socket |> assign_stats() |> assign(refresh: 5)

    if connected?(socket), do: schedule_refresh(socket)
    {:ok, socket}
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
    assign(socket,
      lumens: Dash.lumens(),
      temperature: Dash.temperature(),
      co2: Dash.co2(),
      last_updated_at: Timex.now()
    )
  end

  defp refresh_options do
    [{"1s", 1}, {"5s", 5}, {"15s", 15}, {"30s", 30}, {"60s", 60}]
  end

  defp schedule_refresh(socket) do
    Process.send_after(self(), :self_refresh, socket.assigns.refresh * 1000)
    socket
  end
end
