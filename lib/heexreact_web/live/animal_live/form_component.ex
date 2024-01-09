defmodule HeexreactWeb.AnimalLive.FormComponent do
  use HeexreactWeb, :live_component

  alias Heexreact.Animals

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage animal records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="animal-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:common_name]} type="text" label="Common name" />
        <.input field={@form[:species]} type="text" label="Species" />
        <.input field={@form[:region]} type="text" label="Region" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Animal</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{animal: animal} = assigns, socket) do
    changeset = Animals.change_animal(animal)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"animal" => animal_params}, socket) do
    changeset =
      socket.assigns.animal
      |> Animals.change_animal(animal_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"animal" => animal_params}, socket) do
    save_animal(socket, socket.assigns.action, animal_params)
  end

  defp save_animal(socket, :edit, animal_params) do
    case Animals.update_animal(socket.assigns.animal, animal_params) do
      {:ok, animal} ->
        notify_parent({:saved, animal})

        {:noreply,
         socket
         |> put_flash(:info, "Animal updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_animal(socket, :new, animal_params) do
    case Animals.create_animal(animal_params) do
      {:ok, animal} ->
        notify_parent({:saved, animal})

        {:noreply,
         socket
         |> put_flash(:info, "Animal created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
