defmodule LiveCutie.Monsters do
  @moduledoc """
  The Monsters context.
  """

  import Ecto.Query, warn: false
  alias LiveCutie.Repo

  alias LiveCutie.Monsters.Monster

  @doc """
  Returns the list of monsters.

  ## Examples

      iex> list_monsters()
      [%Monster{}, ...]

  """
  def list_monsters do
    Repo.all(Monster)
  end

  def list_monsters(criteria) when is_list(criteria) do
    query = from(v in Monster)

    Enum.reduce(criteria, query, fn
      {:paginate, %{page: page, per_page: per_page}}, query ->
        from q in query,
          offset: ^((page - 1) * per_page),
          limit: ^per_page

      {:sort, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]
    end)
    |> Repo.all()
  end

  @doc """
  Gets a single monster.

  Raises `Ecto.NoResultsError` if the Monster does not exist.

  ## Examples

      iex> get_monster!(123)
      %Monster{}

      iex> get_monster!(456)
      ** (Ecto.NoResultsError)

  """
  def get_monster!(id), do: Repo.get!(Monster, id)

  @doc """
  Creates a monster.

  ## Examples

      iex> create_monster(%{field: value})
      {:ok, %Monster{}}

      iex> create_monster(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_monster(attrs \\ %{}) do
    %Monster{}
    |> Monster.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a monster.

  ## Examples

      iex> update_monster(monster, %{field: new_value})
      {:ok, %Monster{}}

      iex> update_monster(monster, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_monster(%Monster{} = monster, attrs) do
    monster
    |> Monster.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a monster.

  ## Examples

      iex> delete_monster(monster)
      {:ok, %Monster{}}

      iex> delete_monster(monster)
      {:error, %Ecto.Changeset{}}

  """
  def delete_monster(%Monster{} = monster) do
    Repo.delete(monster)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking monster changes.

  ## Examples

      iex> change_monster(monster)
      %Ecto.Changeset{data: %Monster{}}

  """
  def change_monster(%Monster{} = monster, attrs \\ %{}) do
    Monster.changeset(monster, attrs)
  end
end
