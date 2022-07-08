defmodule LiveCutieWeb.DatePickerLive do
  use LiveCutieWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, date: nil)}
  end

  def handle_event("dates-picked", date, socket) do
    socket = assign(socket, date: date)
    IO.inspect(socket.assigns)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div>
      <form>
        <input
          id="date-picker-input"
          type="text"
          class="form-input"
          value={@date}
          placeholder="Pick a date"
          phx-hook="DatePicker"
        />
      </form>

      <%= if @date do %>
        <p class="mt-6 text-xl">
          Date returned from backend <%= @date %>!
        </p>
      <% end %>
      <br />
      <blockquote><%= inspect(assigns) %></blockquote>
    </div>
    """
  end
end
