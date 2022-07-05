defmodule LiveCutie.PetsTest do
  use LiveCutie.DataCase

  alias LiveCutie.Pets

  describe "pets" do
    alias LiveCutie.Pets.Pet

    import LiveCutie.PetsFixtures

    @invalid_attrs %{cuteness: nil, image: nil, name: nil, species: nil}

    test "list_pets/0 returns all pets" do
      pet = pet_fixture()
      assert Pets.list_pets() == [pet]
    end

    test "get_pet!/1 returns the pet with given id" do
      pet = pet_fixture()
      assert Pets.get_pet!(pet.id) == pet
    end

    test "create_pet/1 with valid data creates a pet" do
      valid_attrs = %{cuteness: "some cuteness", image: "some image", name: "some name", species: "some species"}

      assert {:ok, %Pet{} = pet} = Pets.create_pet(valid_attrs)
      assert pet.cuteness == "some cuteness"
      assert pet.image == "some image"
      assert pet.name == "some name"
      assert pet.species == "some species"
    end

    test "create_pet/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pets.create_pet(@invalid_attrs)
    end

    test "update_pet/2 with valid data updates the pet" do
      pet = pet_fixture()
      update_attrs = %{cuteness: "some updated cuteness", image: "some updated image", name: "some updated name", species: "some updated species"}

      assert {:ok, %Pet{} = pet} = Pets.update_pet(pet, update_attrs)
      assert pet.cuteness == "some updated cuteness"
      assert pet.image == "some updated image"
      assert pet.name == "some updated name"
      assert pet.species == "some updated species"
    end

    test "update_pet/2 with invalid data returns error changeset" do
      pet = pet_fixture()
      assert {:error, %Ecto.Changeset{}} = Pets.update_pet(pet, @invalid_attrs)
      assert pet == Pets.get_pet!(pet.id)
    end

    test "delete_pet/1 deletes the pet" do
      pet = pet_fixture()
      assert {:ok, %Pet{}} = Pets.delete_pet(pet)
      assert_raise Ecto.NoResultsError, fn -> Pets.get_pet!(pet.id) end
    end

    test "change_pet/1 returns a pet changeset" do
      pet = pet_fixture()
      assert %Ecto.Changeset{} = Pets.change_pet(pet)
    end
  end
end
