defmodule HeexreactWeb.Home.Index do
  use HeexreactWeb, :live_view

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <div id="greetings" phx-hook="Greeter" data-name="Pedro" phx-update="ignore" />
      <div class="px-2 py-4 bg-fuchsia-300 rounded-md">
        <h1>This is liveview render</h1>
        <%= if @count do %>
          <h1><%= @count %></h1>
        <% end %>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket |> assign(:count, 0)}
  end

  def handle_event("increment", %{"increment" => increment}, socket) do
    count = socket.assigns.count || 0
    {:noreply, assign(socket, :count, count + increment)}
  end
end
