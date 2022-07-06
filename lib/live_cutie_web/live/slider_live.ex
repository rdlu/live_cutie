defmodule LiveCutieWeb.SliderLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Btus

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(1000, self(), :self_refresh)
    end

    level = 2
    data = Btus.calculate(level)
    socket = assign(socket, data)
    {:ok, socket}
  end

  def handle_event("update", %{"level" => level}, socket) do
    level = String.to_integer(level)
    data = Btus.calculate(level)
    socket = assign(socket, data)
    {:noreply, socket}
  end

  def handle_info(:self_refresh, socket) do
    expiration_time = socket.assigns.expiration_time
    socket = assign(socket, time_remaining: Btus.time_remaining(expiration_time))
    {:noreply, socket}
  end

  defp format_time(time) do
    time
    |> Timex.Duration.from_seconds()
    |> Timex.format_duration(:humanized)
  end
end
