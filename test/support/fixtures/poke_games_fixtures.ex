defmodule LiveCutie.PokeGamesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCutie.PokeGames` context.
  """

  @doc """
  Generate a poke_game.
  """
  def poke_game_fixture(attrs \\ %{}) do
    {:ok, poke_game} =
      attrs
      |> Enum.into(%{
        box_image: "some box_image",
        description: "some description",
        favorite: true,
        generation: 42,
        legendary: [],
        name: "some name",
        platform: "some platform",
        played: :yes,
        starters: [],
        streaming: false
      })
      |> LiveCutie.PokeGames.create_poke_game()

    poke_game
  end
end
