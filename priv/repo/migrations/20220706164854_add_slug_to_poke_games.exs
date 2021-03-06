defmodule LiveCutie.Repo.Migrations.AddSlugToPokeGames do
  use Ecto.Migration

  def change do
    alter table(:poke_games) do
      add(:slug, :string, null: false)
    end

    create(unique_index(:poke_games, [:slug]))
  end
end
