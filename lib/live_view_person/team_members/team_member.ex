defmodule LiveViewPerson.TeamMembers.TeamMember do
  use Ecto.Schema
  import Ecto.Changeset

  schema "team_members" do
    field :name, :string
    field :bucket, :string
    field :bucket_rollup, :string
    field :project, :string
    field :deal, :string
    field :people, :string
    field :organization, :string
    field :date, :date
    field :follow_up, :string
    field :where, :string
    field :meeting_summary, :string
    field :created_time, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(team_member, attrs) do
    team_member
    |> cast(attrs, [
      :name,
      :bucket,
      :bucket_rollup,
      :project,
      :deal,
      :people,
      :organization,
      :date,
      :follow_up,
      :where,
      :meeting_summary,
      :created_time
    ])
    |> validate_required([:name])
  end
end
