defmodule Betsy.Repo do
  use Ecto.Repo,
    otp_app: :betsy,
    adapter: Ecto.Adapters.Postgres
end
