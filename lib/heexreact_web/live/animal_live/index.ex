defmodule HeexreactWeb.AnimalLive.Index do
  use HeexreactWeb, :live_view

  alias Heexreact.Animals
  alias Heexreact.Animals.Animal

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :animal_collection, Animals.list_animal())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Animal")
    |> assign(:animal, Animals.get_animal!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Animal")
    |> assign(:animal, %Animal{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Animal")
    |> assign(:animal, nil)
  end

  @impl true
  def handle_info({HeexreactWeb.AnimalLive.FormComponent, {:saved, animal}}, socket) do
    {:noreply, stream_insert(socket, :animal_collection, animal)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    animal = Animals.get_animal!(id)
    {:ok, _} = Animals.delete_animal(animal)

    {:noreply, stream_delete(socket, :animal_collection, animal)}
  end
end
