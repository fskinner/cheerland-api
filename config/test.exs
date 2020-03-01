use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cheerland_api, CheerlandApiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :cheerland_api, CheerlandApi.Repo,
  username: "postgres",
  password: "postgres",
  database: "cheerland_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :bcrypt_elixir, :log_rounds, 4
