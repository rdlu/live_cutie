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

  def render(assigns) do
    ~H"""
    <h1>Slider Control</h1>
    <div id="slider" class="max-w-lg mx-auto text-center">
      <div class="card bg-white shadow rounded-lg shadow-lg">
        <div class="content p-6">
          <div class="level inline-flex items-center mb-8">
            <img src="images/fan-solid.svg" class="w-10 pr-2" />
            <span class="text-xl font-semibold text-slate-700">
              The current level is <strong><%= Btus.human_level(@level) %></strong>.
            </span>
          </div>
          <form phx-change="update">
            <input type="range" min="0" max="4" name="level" value="2" />
          </form>
          <div class="btus text-2xl leading-none text-slate-900 mt-4">
            <strong><%= @btus %></strong> BTU/h
          </div>
        </div>
      </div>
      <p class="m-4 font-semibold text-indigo-800">
        <%= if @time_remaining > 0 do %>
          <%= format_time(@time_remaining) %> left before shutdown
        <% else %>
          Expired!
        <% end %>
      </p>
    </div>
    """
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
