defmodule LiveCutie.Repo.Migrations.CreatePets do
  use Ecto.Migration

  def change do
    create table(:pets) do
      add :name, :string
      add :species, :string
      add :cuteness, :string
      add :image, :string

      timestamps()
    end
  end
end
