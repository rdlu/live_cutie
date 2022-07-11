defmodule LiveCutieWeb.Components.PerPage do
  use LiveCutieWeb, :live_component
  alias LiveCutieWeb.ParamParser

  @per_page_default 10

  def render(assigns) do
    ~H"""
    <form phx-change="select-per-page" phx-target={@myself} class="flex items-center justify-end mb-4">
      Show
      <select
        name="per-page"
        class="appearance-none bg-slate-200 border border-slate-400 text-slate-700 py-1 px-3 rounded-lg leading-tight font-semibold cursor-pointer text-sm mx-1 focus:outline-none focus:bg-slate-200 focus:border-slate-500"
      >
        <%= options_for_select([5, 10, 15, 20], @per_page) %>
      </select>
      <label for="per-page">per page</label>
    </form>
    """
  end

  def handle_event("select-per-page", %{"per-page" => per_page}, socket) do
    per_page = ParamParser.param_to_integer(per_page, @per_page_default)

    socket = assign(socket, per_page: per_page)

    send(self(), {__MODULE__, :changed, per_page})

    {:noreply, socket}
  end
end
