defmodule Heexreact.AnimalsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Heexreact.Animals` context.
  """

  @doc """
  Generate a animal.
  """
  def animal_fixture(attrs \\ %{}) do
    {:ok, animal} =
      attrs
      |> Enum.into(%{
        common_name: "some common_name",
        region: "some region",
        species: "some species"
      })
      |> Heexreact.Animals.create_animal()

    animal
  end
end
