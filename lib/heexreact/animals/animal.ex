defmodule Heexreact.Animals.Animal do
  use Ecto.Schema
  import Ecto.Changeset

  schema "animal" do
    field :common_name, :string
    field :species, :string
    field :region, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(animal, attrs) do
    animal
    |> cast(attrs, [:common_name, :species, :region])
    |> validate_required([:common_name, :species, :region])
  end
end
