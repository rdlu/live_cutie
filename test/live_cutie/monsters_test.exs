defmodule LiveCutie.MonstersTest do
  use LiveCutie.DataCase

  alias LiveCutie.Monsters

  describe "monsters" do
    alias LiveCutie.Monsters.Monster

    import LiveCutie.MonstersFixtures

    @invalid_attrs %{name: nil, national_id: nil, slug: nil, species: nil, types: nil}

    test "list_monsters/0 returns all monsters" do
      monster = monster_fixture()
      assert Monsters.list_monsters() == [monster]
    end

    test "get_monster!/1 returns the monster with given id" do
      monster = monster_fixture()
      assert Monsters.get_monster!(monster.id) == monster
    end

    test "create_monster/1 with valid data creates a monster" do
      valid_attrs = %{name: "some name", national_id: 42, slug: "some slug", species: "some species", types: []}

      assert {:ok, %Monster{} = monster} = Monsters.create_monster(valid_attrs)
      assert monster.name == "some name"
      assert monster.national_id == 42
      assert monster.slug == "some slug"
      assert monster.species == "some species"
      assert monster.types == []
    end

    test "create_monster/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Monsters.create_monster(@invalid_attrs)
    end

    test "update_monster/2 with valid data updates the monster" do
      monster = monster_fixture()
      update_attrs = %{name: "some updated name", national_id: 43, slug: "some updated slug", species: "some updated species", types: []}

      assert {:ok, %Monster{} = monster} = Monsters.update_monster(monster, update_attrs)
      assert monster.name == "some updated name"
      assert monster.national_id == 43
      assert monster.slug == "some updated slug"
      assert monster.species == "some updated species"
      assert monster.types == []
    end

    test "update_monster/2 with invalid data returns error changeset" do
      monster = monster_fixture()
      assert {:error, %Ecto.Changeset{}} = Monsters.update_monster(monster, @invalid_attrs)
      assert monster == Monsters.get_monster!(monster.id)
    end

    test "delete_monster/1 deletes the monster" do
      monster = monster_fixture()
      assert {:ok, %Monster{}} = Monsters.delete_monster(monster)
      assert_raise Ecto.NoResultsError, fn -> Monsters.get_monster!(monster.id) end
    end

    test "change_monster/1 returns a monster changeset" do
      monster = monster_fixture()
      assert %Ecto.Changeset{} = Monsters.change_monster(monster)
    end
  end
end
