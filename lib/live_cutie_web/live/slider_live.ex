defmodule LiveCutieWeb.SliderLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.Btus

  def mount(_params, _session, socket) do
    level = 2
    socket = assign(socket, level: level, btus: Btus.calculate(level))
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Slider Control</h1>
    <div id="slider" class="max-w-lg mx-auto text-center">
      <div class="card bg-white shadow rounded-lg shadow-lg">
        <div class="content p-6">
          <div class="level inline-flex items-center mb-8">
            <img src="images/fan-solid.svg" class="w-10 pr-2">
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
    </div>
    """
  end

  def handle_event("update", %{"level" => level}, socket) do
    level = String.to_integer(level)
    btus = Btus.calculate(level)
    socket = assign(socket, level: level, btus: btus)
    {:noreply, socket}
  end
end
