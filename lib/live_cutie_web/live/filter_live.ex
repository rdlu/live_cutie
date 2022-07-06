defmodule LiveCutieWeb.FilterLive do
  use LiveCutieWeb, :live_view
  alias LiveCutie.Pets

  def mount(_params, _session, socket) do
    socket = assign_defaults(socket)

    {:ok, socket}
  end

  def handle_event("filter", %{"species" => species, "cuteness" => cuteness}, socket) do
    params = [species: species, cuteness: cuteness]
    pets = Pets.list_pets(params)
    socket = assign(socket, params ++ [pets: pets])
    {:noreply, socket}
  end

  def handle_event("clear", _, socket) do
    socket = assign_defaults(socket)
    {:noreply, socket}
  end

  defp cuteness_checkbox(assigns) do
    assigns = Enum.into(assigns, %{})

    ~H"""
    <label class="overflow-hidden border-t border-b border-slate-400 bg-slate-300 text-lg font-semibold leading-5 hover:bg-slate-400 hover:cursor-pointer first-of-type:border-l first-of-type:border-r first-of-type:rounded-l-lg last-of-type:border-l last-of-type:border-r last-of-type:rounded-r-lg">
      <input
        type="checkbox"
        id={"cuteness-#{@cuteness}"}
        name="cuteness[]"
        value={@cuteness}
        checked={@checked}
        class="opacity-0 fixed w-0 peer"
      />
      <span class="peer-checked:bg-indigo-300 inline-flex py-4 px-4">
        <%= for _ <- 1..@cuteness do %>
          <img src="images/heart-solid.svg" alt="Heart" class="w-4 h-4" />
        <% end %>
      </span>
    </label>
    """
  end

  defp species_options do
    [
      "All Species": "",
      Birds: "bird",
      Cats: "cat",
      Dogs: "dog"
    ]
  end

  defp assign_defaults(socket) do
    assign(socket, pets: Pets.list_pets(), species: "", cuteness: [])
  end
end
