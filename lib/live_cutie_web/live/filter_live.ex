defmodule LiveCutieWeb.FilterLive do
  use LiveCutieWeb, :live_view
  alias LiveCutie.Pets

  def mount(_params, _session, socket) do
    socket = assign_defaults(socket)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Cute Pets</h1>
    <div id="filter">
      <form id="max-w-xl mx-auto mb-4" phx-change="filter">
        <div class="filters flex items-baseline justify-around">
          <select
            name="species"
            class="appearance-none w-1/3 bg-slate-200 border border-slate-400 text-slate-700 py-3 px-4 rounded-lg leading-tight font-semibold cursor-pointer"
          >
            <%= options_for_select(species_options(), @species) %>
          </select>
          <div class="cuteness flex">
            <input type="hidden" name="cuteness[]" value="" />
            <%= for i <- 3..5  do %>
              <%= cuteness_checkbox(cuteness: i, checked: to_string(i) in @cuteness) %>
            <% end %>
          </div>
          <button
            type="reset"
            phx-click="clear"
            class=" bg-slate-200 border border-slate-400 text-slate-700 py-3 px-4 rounded-lg leading-tight font-semibold hover:bg-slate-400 hover:cursor-pointer"
          >
            Clear All
          </button>
        </div>
      </form>
      <div class="pets flex flex-wrap justify-center">
        <%= for pet <- @pets do %>
          <div class="card flex flex-col m-6 max-w-sm rounded bg-slate-100 overflow-hidden shadow-lg place-content-around">
            <img src={pet.image} />
            <div class="content px-6 py-4 mt-2 flex justify-between">
              <div class="name pb-3 text-center text-slate-900 font-bold text-xl">
                <%= pet.name %>
              </div>
              <div class="cuteness text-slate-700 font-semibold text-xl">
                <div class="inline-flex py-3 px-4">
                  <%= for _ <- 1..String.to_integer(pet.cuteness) do %>
                    <img src="images/heart-solid.svg" alt="Heart" class="w-3 h-3" />
                  <% end %>
                </div>
              </div>
              <div class="species uppercase inline-block self-center bg-slate-300 rounded-full px-2 py-1 text-sm font-semibold text-slate-700">
                <%= pet.species %>
              </div>
            </div>
          </div>
        <% end %>
        <%= if Enum.empty?(@pets) do %>
          <div class="p-20 m-20 font-semibold text-red-500 rounded bg-slate-100 overflow-hidden shadow-lg">
            Nothing found here. Please change or remove some filters.
          </div>
        <% end %>
      </div>
    </div>
    """
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
