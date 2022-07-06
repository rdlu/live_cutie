defmodule LiveCutie.MonstersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCutie.Monsters` context.
  """

  @doc """
  Generate a monster.
  """
  def monster_fixture(attrs \\ %{}) do
    {:ok, monster} =
      attrs
      |> Enum.into(%{
        name: "some name",
        national_id: 42,
        slug: "some slug",
        species: "some species",
        types: []
      })
      |> LiveCutie.Monsters.create_monster()

    monster
  end
end
