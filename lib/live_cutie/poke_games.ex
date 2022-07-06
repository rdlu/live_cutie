defmodule LiveCutie.PokeGames do
  @moduledoc """
  The PokeGames context.
  """

  import Ecto.Query, warn: false
  alias LiveCutie.Repo

  alias LiveCutie.PokeGames.PokeGame

  @doc """
  Returns the list of poke_games.

  ## Examples

      iex> list_poke_games()
      [%PokeGame{}, ...]

  """
  def list_poke_games do
    Repo.all(PokeGame)
  end

  @doc """
  Gets a single poke_game.

  Raises `Ecto.NoResultsError` if the Poke game does not exist.

  ## Examples

      iex> get_poke_game!(123)
      %PokeGame{}

      iex> get_poke_game!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poke_game!(id), do: Repo.get!(PokeGame, id)

  def get_by_slug(slug), do: Repo.get_by(PokeGame, slug: slug)

  @doc """
  Creates a poke_game.

  ## Examples

      iex> create_poke_game(%{field: value})
      {:ok, %PokeGame{}}

      iex> create_poke_game(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poke_game(attrs \\ %{}) do
    %PokeGame{}
    |> PokeGame.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poke_game.

  ## Examples

      iex> update_poke_game(poke_game, %{field: new_value})
      {:ok, %PokeGame{}}

      iex> update_poke_game(poke_game, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poke_game(%PokeGame{} = poke_game, attrs) do
    poke_game
    |> PokeGame.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a poke_game.

  ## Examples

      iex> delete_poke_game(poke_game)
      {:ok, %PokeGame{}}

      iex> delete_poke_game(poke_game)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poke_game(%PokeGame{} = poke_game) do
    Repo.delete(poke_game)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poke_game changes.

  ## Examples

      iex> change_poke_game(poke_game)
      %Ecto.Changeset{data: %PokeGame{}}

  """
  def change_poke_game(%PokeGame{} = poke_game, attrs \\ %{}) do
    PokeGame.changeset(poke_game, attrs)
  end
end
