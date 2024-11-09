defmodule LiveViewPersonWeb.TeamMemberLive.Index do
  use LiveViewPersonWeb, :live_view

  alias LiveViewPerson.TeamMembers
  alias LiveViewPerson.TeamMembers.TeamMember

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, team_members: list_team_members())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :show, %{"id" => id}) do
    socket
    |> assign(:page_title, "Show Team Member")
    |> assign(:team_member, TeamMembers.get_team_member!(id))
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Team Member")
    |> assign(:team_member, TeamMembers.get_team_member!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Team Member")
    |> assign(:team_member, %TeamMember{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Team Members")
    |> assign(:team_member, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    team_member = TeamMembers.get_team_member!(id)
    {:ok, _} = TeamMembers.delete_team_member(team_member)

    {:noreply, assign(socket, :team_members, list_team_members())}
  end

  defp list_team_members do
    TeamMembers.list_team_members()
  end
end
