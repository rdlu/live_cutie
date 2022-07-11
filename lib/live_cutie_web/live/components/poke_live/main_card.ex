defmodule LiveCutieWeb.Components.PokeLive.MainCard do
  use LiveCutieWeb, :live_component

  alias LiveCutie.PokeGames

  def handle_event("toggle-status", %{"id" => id}, socket) do
    game = PokeGames.get_poke_game!(id)

    # Update the game's status to the opposite of its current status:
    {:ok, game} = PokeGames.toggle_status_poke_game(game)

    {:noreply, socket}
  end

  defp streaming_class(game) do
    if game.streaming do
      "status-on"
    else
      "status-off"
    end
  end

  defp platform_img(game) do
    "/images/hardware/#{Slug.slugify(game.platform)}.svg"
  end

  defp simple_list(list) do
    list |> Enum.join(", ")
  end
end
