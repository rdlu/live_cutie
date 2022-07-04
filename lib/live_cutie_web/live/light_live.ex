defmodule LiveCutieWeb.LightLive do
  use LiveCutieWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :brightness, 10)
    IO.inspect(socket)
    {:ok, socket}
  end

  def render(assigns) do
    style = "width: #{assigns[:brightness]}%; transition: width 2s ease;"
    ~H"""
    <h1>Lights Control</h1>
    <div id="light" class="max-w-xl mx-auto text-center">
      <div class="flex h-12 overflow-hidden text-base bg-slate-300 rounded-lg mb-8 border-2 border-slate-800">
        <span class="flex flex-col justify-center text-slate-900 text-center whitespace-nowrap bg-gradient-to-r from-indigo-500 to-cyan-500 font-bold" style={style}>
          <%= @brightness %>
        </span>
      </div>
      <button phx-click="up" class="bg-lime-300 mx-1 py-2 px-4 border border-slate-400 border-2 rounded-lg shadow-sm transition ease-in-out duration-150 outline-none hover:bg-slate-300 disabled:opacity-50 disabled:cursor-not-allowed">
        <img src="images/arrow-circle-up-solid.svg" alt="Lights Up" class="w-10">
      </button>
      <button phx-click="down" class="bg-violet-300 mx-1 py-2 px-4 border border-slate-400 border-2 rounded-lg shadow-sm transition ease-in-out duration-150 outline-none hover:bg-slate-300 disabled:opacity-50 disabled:cursor-not-allowed">
        <img src="images/arrow-circle-down-solid.svg" alt="Lights Down" class="w-10">
      </button>
      <button phx-click="off" class="bg-indigo-300 mx-1 py-2 px-4 border border-slate-400 border-2 rounded-lg shadow-sm transition ease-in-out duration-150 outline-none hover:bg-slate-300 disabled:opacity-50 disabled:cursor-not-allowed">
        <img src="images/moon.svg" alt="Lights Off" class="w-10">
      </button>
      <button phx-click="on" class="bg-yellow-300 mx-1 py-2 px-4 border border-slate-400 border-2 rounded-lg shadow-sm transition ease-in-out duration-150 outline-none hover:bg-slate-300 disabled:opacity-50 disabled:cursor-not-allowed">
        <img src="images/sun.svg" alt="Lights On" class="w-10">
      </button>
    </div>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = assign(socket, :brightness, socket.assigns.brightness + 10)
    IO.inspect(socket)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = assign(socket, :brightness, socket.assigns.brightness - 10)
    IO.inspect(socket)
    {:noreply, socket}
  end
end
