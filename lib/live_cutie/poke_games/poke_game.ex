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
      :streaming
    ])
    |> validate_required([
      :name,
      :generation,
      :platform,
      :box_image,
      :description,
      :starters
    ])
  end
end
