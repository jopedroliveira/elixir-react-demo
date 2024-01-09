defmodule Heexreact.AnimalsTest do
  use Heexreact.DataCase

  alias Heexreact.Animals

  describe "animal" do
    alias Heexreact.Animals.Animal

    import Heexreact.AnimalsFixtures

    @invalid_attrs %{common_name: nil, species: nil, region: nil}

    test "list_animal/0 returns all animal" do
      animal = animal_fixture()
      assert Animals.list_animal() == [animal]
    end

    test "get_animal!/1 returns the animal with given id" do
      animal = animal_fixture()
      assert Animals.get_animal!(animal.id) == animal
    end

    test "create_animal/1 with valid data creates a animal" do
      valid_attrs = %{common_name: "some common_name", species: "some species", region: "some region"}

      assert {:ok, %Animal{} = animal} = Animals.create_animal(valid_attrs)
      assert animal.common_name == "some common_name"
      assert animal.species == "some species"
      assert animal.region == "some region"
    end

    test "create_animal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Animals.create_animal(@invalid_attrs)
    end

    test "update_animal/2 with valid data updates the animal" do
      animal = animal_fixture()
      update_attrs = %{common_name: "some updated common_name", species: "some updated species", region: "some updated region"}

      assert {:ok, %Animal{} = animal} = Animals.update_animal(animal, update_attrs)
      assert animal.common_name == "some updated common_name"
      assert animal.species == "some updated species"
      assert animal.region == "some updated region"
    end

    test "update_animal/2 with invalid data returns error changeset" do
      animal = animal_fixture()
      assert {:error, %Ecto.Changeset{}} = Animals.update_animal(animal, @invalid_attrs)
      assert animal == Animals.get_animal!(animal.id)
    end

    test "delete_animal/1 deletes the animal" do
      animal = animal_fixture()
      assert {:ok, %Animal{}} = Animals.delete_animal(animal)
      assert_raise Ecto.NoResultsError, fn -> Animals.get_animal!(animal.id) end
    end

    test "change_animal/1 returns a animal changeset" do
      animal = animal_fixture()
      assert %Ecto.Changeset{} = Animals.change_animal(animal)
    end
  end
end
