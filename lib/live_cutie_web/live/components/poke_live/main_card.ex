defmodule LiveCutieWeb.Components.PokeLive.MainCard do
  use LiveCutieWeb, :live_component

  alias LiveCutie.PokeGames

  def handle_event("toggle-status", %{"id" => id}, socket) do
    game = PokeGames.get_poke_game!(id)

    # Update the game's status to the opposite of its current status:
    {:ok, _} = PokeGames.toggle_status_poke_game(game)

    {:noreply, socket}
  end

  defp streaming_class(game) do
    if game.streaming do
      "status-on"
    else
      "status-off"
    end
  end

  defp platform_img(%{platform: nil}) do
    "/images/question-circle.svg"
  end

  defp platform_img(%{platform: platform}) do
    "/images/hardware/#{Slug.slugify(platform)}.svg"
  end

  defp simple_list(list) do
    list |> Enum.join(", ")
  end
end
