defmodule Heexreact.Repo.Migrations.CreateAnimal do
  use Ecto.Migration

  def change do
    create table(:animal) do
      add :common_name, :string
      add :species, :string
      add :region, :string

      timestamps(type: :utc_datetime)
    end
  end
end
