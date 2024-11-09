defmodule LiveViewPersonWeb.TeamMembers.DetailComponent do
  use LiveViewPersonWeb, :live_component
  import LiveViewPersonWeb.CoreComponents

  def detail_item(assigns) do
    ~H"""
    <div class="px-4 py-3 flex justify-between items-center">
      <dt class="font-medium text-gray-500 flex items-center gap-2">
        <.icon name={@icon} class="h-5 w-5" />
        <%= @label %>
      </dt>
      <dd><%= @value %></dd>
    </div>
    """
  end

  def render(assigns) do
    ~H"""
    <div>
      <.sidepeek id="my-panel" on_cancel={JS.navigate(~p"/team_members")} show={@live_action == :show}>
        <:title><%= @team_member.name %></:title>

        <div class="space-y-4">
          <dl class="divide-y">
            <.detail_item icon="hero-chart-bar" label="Bucket" value={@team_member.bucket} />
            <.detail_item
              icon="hero-chart-bar"
              label="Bucket Rollup"
              value={@team_member.bucket_rollup}
            />
            <.detail_item icon="hero-briefcase" label="Project" value={@team_member.project} />
            <.detail_item icon="hero-currency-dollar" label="Deal" value={@team_member.deal} />
            <.detail_item icon="hero-users" label="People" value={@team_member.people} />
            <.detail_item
              icon="hero-building-office"
              label="Organization"
              value={@team_member.organization}
            />
            <.detail_item
              icon="hero-calendar"
              label="Date"
              value={
                if @team_member.date, do: Calendar.strftime(@team_member.date, "%B %d, %Y"), else: ""
              }
            />
            <.detail_item icon="hero-bell" label="Follow Up" value={@team_member.follow_up} />
            <.detail_item icon="hero-map-pin" label="Where" value={@team_member.where} />
            <.detail_item
              icon="hero-document-text"
              label="Meeting Summary"
              value={@team_member.meeting_summary}
            />
            <.detail_item
              icon="hero-clock"
              label="Created Time"
              value={
                if @team_member.created_time,
                  do: Calendar.strftime(@team_member.created_time, "%B %d, %Y %H:%M"),
                  else: ""
              }
            />
          </dl>
        </div>
      </.sidepeek>
    </div>
    """
  end
end
