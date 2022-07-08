defmodule LiveCutieWeb.DatePickerLive do
  use LiveCutieWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, date: nil, ex_date: nil, js_date: nil)}
  end

  def handle_event("dates-picked", js_date, socket) do
    {:ok, ex_date, _} = DateTime.from_iso8601(js_date)

    socket =
      assign(socket,
        js_date: js_date,
        date: Timex.format!(ex_date, "%d/%m/%Y", :strftime),
        ex_date: ex_date
      )

    {:ok, socket}
    IO.inspect(socket.assigns)
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Date Picker</h1>
    <p class="p-1 m-10 text-center">
      This is a 3rd party JS library activating Phx Hooks that are handled by the backend and answered back.
    </p>
    <div class="flex flex-col items-center gap-4">
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
        <h2>Date returned from backend!</h2>
        <h3>Sent using JS</h3>
        <code><%= inspect(@js_date) %></code>
        <h3>Date parsed by Elixir <strong>DateTime</strong></h3>
        <code><%= inspect(@ex_date) %></code>
      <% end %>
    </div>
    """
  end
end
