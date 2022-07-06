defmodule LiveCutie.PokeGamesTest do
  use LiveCutie.DataCase

  alias LiveCutie.PokeGames

  describe "poke_games" do
    alias LiveCutie.PokeGames.PokeGame

    import LiveCutie.PokeGamesFixtures

    @invalid_attrs %{box_image: nil, description: nil, favorite: nil, generation: nil, legendary: nil, name: nil, platform: nil, played: nil, starters: nil}

    test "list_poke_games/0 returns all poke_games" do
      poke_game = poke_game_fixture()
      assert PokeGames.list_poke_games() == [poke_game]
    end

    test "get_poke_game!/1 returns the poke_game with given id" do
      poke_game = poke_game_fixture()
      assert PokeGames.get_poke_game!(poke_game.id) == poke_game
    end

    test "create_poke_game/1 with valid data creates a poke_game" do
      valid_attrs = %{box_image: "some box_image", description: "some description", favorite: true, generation: 42, legendary: [], name: "some name", platform: "some platform", played: :yes, starters: []}

      assert {:ok, %PokeGame{} = poke_game} = PokeGames.create_poke_game(valid_attrs)
      assert poke_game.box_image == "some box_image"
      assert poke_game.description == "some description"
      assert poke_game.favorite == true
      assert poke_game.generation == 42
      assert poke_game.legendary == []
      assert poke_game.name == "some name"
      assert poke_game.platform == "some platform"
      assert poke_game.played == :yes
      assert poke_game.starters == []
    end

    test "create_poke_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = PokeGames.create_poke_game(@invalid_attrs)
    end

    test "update_poke_game/2 with valid data updates the poke_game" do
      poke_game = poke_game_fixture()
      update_attrs = %{box_image: "some updated box_image", description: "some updated description", favorite: false, generation: 43, legendary: [], name: "some updated name", platform: "some updated platform", played: :no, starters: []}

      assert {:ok, %PokeGame{} = poke_game} = PokeGames.update_poke_game(poke_game, update_attrs)
      assert poke_game.box_image == "some updated box_image"
      assert poke_game.description == "some updated description"
      assert poke_game.favorite == false
      assert poke_game.generation == 43
      assert poke_game.legendary == []
      assert poke_game.name == "some updated name"
      assert poke_game.platform == "some updated platform"
      assert poke_game.played == :no
      assert poke_game.starters == []
    end

    test "update_poke_game/2 with invalid data returns error changeset" do
      poke_game = poke_game_fixture()
      assert {:error, %Ecto.Changeset{}} = PokeGames.update_poke_game(poke_game, @invalid_attrs)
      assert poke_game == PokeGames.get_poke_game!(poke_game.id)
    end

    test "delete_poke_game/1 deletes the poke_game" do
      poke_game = poke_game_fixture()
      assert {:ok, %PokeGame{}} = PokeGames.delete_poke_game(poke_game)
      assert_raise Ecto.NoResultsError, fn -> PokeGames.get_poke_game!(poke_game.id) end
    end

    test "change_poke_game/1 returns a poke_game changeset" do
      poke_game = poke_game_fixture()
      assert %Ecto.Changeset{} = PokeGames.change_poke_game(poke_game)
    end
  end
end
