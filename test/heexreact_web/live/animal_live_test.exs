defmodule HeexreactWeb.AnimalLiveTest do
  use HeexreactWeb.ConnCase

  import Phoenix.LiveViewTest
  import Heexreact.AnimalsFixtures

  @create_attrs %{common_name: "some common_name", species: "some species", region: "some region"}
  @update_attrs %{common_name: "some updated common_name", species: "some updated species", region: "some updated region"}
  @invalid_attrs %{common_name: nil, species: nil, region: nil}

  defp create_animal(_) do
    animal = animal_fixture()
    %{animal: animal}
  end

  describe "Index" do
    setup [:create_animal]

    test "lists all animal", %{conn: conn, animal: animal} do
      {:ok, _index_live, html} = live(conn, ~p"/animal")

      assert html =~ "Listing Animal"
      assert html =~ animal.common_name
    end

    test "saves new animal", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/animal")

      assert index_live |> element("a", "New Animal") |> render_click() =~
               "New Animal"

      assert_patch(index_live, ~p"/animal/new")

      assert index_live
             |> form("#animal-form", animal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#animal-form", animal: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/animal")

      html = render(index_live)
      assert html =~ "Animal created successfully"
      assert html =~ "some common_name"
    end

    test "updates animal in listing", %{conn: conn, animal: animal} do
      {:ok, index_live, _html} = live(conn, ~p"/animal")

      assert index_live |> element("#animal-#{animal.id} a", "Edit") |> render_click() =~
               "Edit Animal"

      assert_patch(index_live, ~p"/animal/#{animal}/edit")

      assert index_live
             |> form("#animal-form", animal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#animal-form", animal: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/animal")

      html = render(index_live)
      assert html =~ "Animal updated successfully"
      assert html =~ "some updated common_name"
    end

    test "deletes animal in listing", %{conn: conn, animal: animal} do
      {:ok, index_live, _html} = live(conn, ~p"/animal")

      assert index_live |> element("#animal-#{animal.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#animal-#{animal.id}")
    end
  end

  describe "Show" do
    setup [:create_animal]

    test "displays animal", %{conn: conn, animal: animal} do
      {:ok, _show_live, html} = live(conn, ~p"/animal/#{animal}")

      assert html =~ "Show Animal"
      assert html =~ animal.common_name
    end

    test "updates animal within modal", %{conn: conn, animal: animal} do
      {:ok, show_live, _html} = live(conn, ~p"/animal/#{animal}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Animal"

      assert_patch(show_live, ~p"/animal/#{animal}/show/edit")

      assert show_live
             |> form("#animal-form", animal: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#animal-form", animal: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/animal/#{animal}")

      html = render(show_live)
      assert html =~ "Animal updated successfully"
      assert html =~ "some updated common_name"
    end
  end
end
