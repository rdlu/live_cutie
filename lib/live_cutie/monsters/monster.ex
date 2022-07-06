defmodule LiveCutie.Monsters.Monster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "monsters" do
    field :name, :string
    field :national_id, :integer
    field :slug, :string
    field :species, :string
    field :types, {:array, :string}

    timestamps()
  end

  @doc false
  def changeset(monster, attrs) do
    monster
    |> cast(attrs, [:name, :species, :types, :national_id, :slug])
    |> update_slug
    |> validate_required([:name, :species, :types, :national_id, :slug])
    |> validate_inclusion(:types, combined_types())
  end

  defp update_slug(changeset) do
    changeset
    |> put_change(:slug, Slug.slugify(changeset.changes.name))
  end

  def combined_types do
    for t1 <- types_list(), t2 <- types_list(), t1 != t2, do: [t1, t2]
  end

  defp types_list do
    [
      "normal",
      "fire",
      "water",
      "electric",
      "grass",
      "ice",
      "fighting",
      "poison",
      "ground",
      "flying",
      "psychic",
      "bug",
      "rock",
      "ghost",
      "dragon",
      "dark",
      "steel",
      "fairy"
    ]
  end
end
