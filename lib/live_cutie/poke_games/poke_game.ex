defmodule LiveCutie.PokeGames.PokeGame do
  use Ecto.Schema
  import Ecto.Changeset

  schema "poke_games" do
    field :box_image, :string,
      default: "https://placeholder.pics/svg/300/DEDEDE/555555/No%20cover%20yet"

    field :description, :string
    field :favorite, :boolean, default: false
    field :streaming, :boolean, default: false
    field :generation, :integer
    field :legendary, {:array, :string}, default: []
    field :name, :string
    field :platform, :string
    field :played, Ecto.Enum, values: [:yes, :no, :soon], default: :no
    field :starters, {:array, :string}, default: ["Pikachu"]
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
      :description,
      :starters,
      :legendary,
      :played,
      :favorite,
      :streaming
    ])
    |> update_slug()
    |> validate_required([
      :name,
      :generation,
      :platform,
      :box_image,
      :description,
      :starters,
      :slug
    ])
    |> validate_length(:name, min: 2, max: 100)
    |> validate_length(:starters, min: 1, max: 3)
    |> validate_number(:generation, greater_than: 0)
    |> validate_inclusion(:platform, platforms_list())
  end

  defp update_slug(changeset, source \\ :name) do
    IO.inspect(changeset)

    if changeset.changes[source] do
      changeset
      |> put_change(:slug, Slug.slugify(changeset.changes[source] || ""))
    else
      changeset
    end
  end

  def platforms_list do
    [
      "Game Boy",
      "Game Boy Color",
      "Game Boy Advance",
      "Nintendo DS",
      "Nintendo 3DS",
      "Nintendo Switch",
      "Wii",
      "Wii U",
      "NES",
      "SNES",
      "Nintendo 64"
    ]
  end
end
