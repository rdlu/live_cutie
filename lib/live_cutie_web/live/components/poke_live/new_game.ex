defmodule LiveCutieWeb.Components.PokeLive.NewGame do
  use LiveCutieWeb, :live_component

  alias LiveCutie.PokeGames

  def mount(socket) do
    changeset = PokeGames.change_poke_game(%PokeGames.PokeGame{})

    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"poke_game" => params}, socket) do
    case PokeGames.create_poke_game(params) do
      {:ok, game} ->
        socket =
          put_flash(socket, :info, "New stream added: #{game.name}")
          |> push_patch(
            to:
              Routes.live_path(
                socket,
                socket.assigns.target,
                slug: game.slug
              )
          )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        # Assign errored changeset for form.
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"poke_game" => params}, socket) do
    changeset =
      %PokeGames.PokeGame{}
      |> PokeGames.change_poke_game(params)
      |> Map.put(:action, :insert)

    socket = assign(socket, changeset: changeset)

    {:noreply, socket}
  end

  defp text_input_class do
    "focus:outline-none:border-indigo-300:ring:ring-indigo-300 w-full appearance-none px-3 py-2 border border-slate-400 rounded-md transition duration-150 ease-in-out text-base text-xl"
  end

  defp label_input_class do
    "block text-lg font-medium text-slate-600 mb-2"
  end

  defp submit_class do
    "focus:outline-none focus:border-green-700 focus:ring focus:ring-green-300 hover:bg-green-700 inline-block no-underline py-2 px-4 border border-transparent font-medium rounded-md text-white bg-green-500 transition duration-150 ease-in-out outline-none flex-initial text-lg"
  end
end
