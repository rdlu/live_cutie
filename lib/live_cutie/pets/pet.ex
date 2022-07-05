defmodule LiveCutie.Pets.Pet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "pets" do
    field :cuteness, :string
    field :image, :string
    field :name, :string
    field :species, :string

    timestamps()
  end

  @doc false
  def changeset(pet, attrs) do
    pet
    |> cast(attrs, [:name, :species, :cuteness, :image])
    |> validate_required([:name, :species, :cuteness, :image])
  end
end
