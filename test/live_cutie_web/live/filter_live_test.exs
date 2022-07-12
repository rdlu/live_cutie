defmodule LiveCutieWeb.FilterLiveTest do
  use LiveCutieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "filters pets by species and cuteness", %{conn: conn} do
    dog_1 = create_pet(name: "A", cuteness: "3", species: "dog")
    dog_2 = create_pet(name: "B", cuteness: "4", species: "dog")
    cat_2 = create_pet(name: "C", cuteness: "5", species: "cat")

    {:ok, view, _html} = live(conn, "/filter")

    assert has_element?(view, pet_card(dog_1))
    assert has_element?(view, pet_card(dog_2))
    assert has_element?(view, pet_card(cat_2))

    view
    |> form("#change-filter", %{species: "dog", cuteness: ["3"]})
    |> render_change()

    assert has_element?(view, pet_card(dog_1))
    refute has_element?(view, pet_card(dog_2))
    refute has_element?(view, pet_card(cat_2))
  end

  test "initially renders pets of all species and cuteness", %{conn: conn} do
    dog = create_pet(name: "A", cuteness: "5", species: "dog")
    cat = create_pet(name: "B", cuteness: "4", species: "cat")

    {:ok, view, _html} = live(conn, "/filter")

    assert has_element?(view, pet_card(dog))
    assert has_element?(view, pet_card(cat))
  end

  defp pet_card(pet), do: "#pet-#{pet.id}"

  def create_pet(attrs) do
    {:ok, pet} =
      attrs
      |> Enum.into(%{image: "image"})
      |> LiveCutie.Pets.create_pet()

    pet
  end
end
