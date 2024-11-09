defmodule LiveViewPerson.Repo do
  use Ecto.Repo,
    otp_app: :live_view_person,
    adapter: Ecto.Adapters.Postgres
end
