defmodule LiveCutie.Repo.Migrations.CreateMonsters do
  use Ecto.Migration

  def change do
    create table(:monsters) do
      add :name, :string
      add :species, :string
      add :types, {:array, :string}
      add :national_id, :integer
      add :slug, :string

      timestamps()
    end
  end
end
