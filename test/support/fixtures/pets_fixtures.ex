defmodule LiveCutie.PetsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LiveCutie.Pets` context.
  """

  @doc """
  Generate a pet.
  """
  def pet_fixture(attrs \\ %{}) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{
        cuteness: "some cuteness",
        image: "some image",
        name: "some name",
        species: "some species"
      })
      |> LiveCutie.Pets.create_pet()

    pet
  end
end
