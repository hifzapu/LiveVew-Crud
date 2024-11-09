defmodule LiveViewPerson.Repo.Migrations.CreateTableTeamMembers do
  use Ecto.Migration

  def change do
    create table(:team_members) do
      add :name, :string
      add :bucket, :string
      add :bucket_rollup, :string
      add :project, :string
      add :deal, :string
      add :people, :string
      add :organization, :string
      add :date, :date
      add :follow_up, :string
      add :where, :string
      add :meeting_summary, :string
      add :created_time, :utc_datetime

      timestamps()
    end
  end
end
