defmodule LiveCutie.Repo.Migrations.CreatePokeGames do
  use Ecto.Migration

  def change do
    create table(:poke_games) do
      add(:name, :string)
      add(:generation, :integer)
      add(:platform, :string)
      add(:box_image, :string)
      add(:description, :text)
      add(:starters, {:array, :string})
      add(:legendary, {:array, :string})
      add(:played, :string)
      add(:favorite, :boolean, default: false, null: false)
      add(:streaming, :boolean, default: false, null: false)
      add(:related, references(:poke_games, on_delete: :nothing))

      timestamps()
    end

    create(index(:poke_games, [:related]))
  end
end
