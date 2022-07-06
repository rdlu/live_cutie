defmodule LiveCutie.PokeGames.PokeGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "poke_games" do
    field :box_image, :string
    field :description, :string
    field :favorite, :boolean, default: false
    field :streaming, :boolean, default: false
    field :generation, :integer
    field :legendary, {:array, :string}, default: []
    field :name, :string
    field :platform, :string
    field :played, Ecto.Enum, values: [:yes, :no, :soon], default: :no
    field :starters, {:array, :string}
    field :related, :id
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(poke_game, attrs) do
    poke_game
    |> cast(attrs, [
      :name,
      :generation,
      :platform,
      :box_image,
      :description,
      :starters,
      :legendary,
      :played,
      :favorite,
      :streaming,
      :slug
    ])
    |> update_slug
    |> validate_required([
      :name,
      :generation,
      :platform,
      :box_image,
      :description,
      :starters,
      :slug
    ])
  end

  defp update_slug(changeset) do
    changeset
    |> put_change(:slug, Slug.slugify(changeset.changes.name))
  end
end
