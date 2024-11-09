defmodule LiveViewPersonWeb.TeamMembers.FormComponent do
  use LiveViewPersonWeb, :live_component

  alias LiveViewPerson.TeamMembers

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage team member records in your database.</:subtitle>
      </.header>

      <.simple_form
        :let={f}
        for={@changeset}
        id="team_member-form"
        phx-change="validate"
        phx-target={@myself}
        phx-submit="save"
      >
        <.input field={{f, :name}} type="text" label="Name" />
        <.input field={{f, :bucket}} type="text" label="Bucket" />
        <.input field={{f, :bucket_rollup}} type="text" label="Bucket Rollup" />
        <.input field={{f, :project}} type="text" label="Project" />
        <.input field={{f, :deal}} type="text" label="Deal" />
        <.input field={{f, :people}} type="text" label="People" />
        <.input field={{f, :organization}} type="text" label="Organization" />
        <.input field={{f, :date}} type="date" label="Date" />
        <.input field={{f, :follow_up}} type="text" label="Follow Up" />
        <.input field={{f, :where}} type="text" label="Where" />
        <.input field={{f, :meeting_summary}} type="text" label="Meeting Summary" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Team Member</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{team_member: team_member} = assigns, socket) do
    changeset = TeamMembers.change_team_member(team_member)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"team_member" => team_member_params}, socket) do
    changeset =
      socket.assigns.team_member
      |> TeamMembers.change_team_member(team_member_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"team_member" => team_member_params}, socket) do
    save_team_member(socket, socket.assigns.action, team_member_params)
  end

  defp save_team_member(socket, :edit, team_member_params) do
    case TeamMembers.update_team_member(socket.assigns.team_member, team_member_params) do
      {:ok, _team_member} ->
        {:noreply,
         socket
         |> put_flash(:info, "Team member updated successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_team_member(socket, :new, team_member_params) do
    team_member_params = Map.put(team_member_params, "created_time", DateTime.utc_now())

    case TeamMembers.create_team_member(team_member_params) do
      {:ok, _team_member} ->
        {:noreply,
         socket
         |> put_flash(:info, "Team member created successfully")
         |> push_navigate(to: socket.assigns.navigate)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
