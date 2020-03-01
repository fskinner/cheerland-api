defmodule CheerlandApi.Repo do
  use Ecto.Repo,
    otp_app: :cheerland_api,
    adapter: Ecto.Adapters.Postgres
end
