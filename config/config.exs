# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :cheerland_api,
  ecto_repos: [CheerlandApi.Repo]

# Configures the endpoint
config :cheerland_api, CheerlandApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zj82jfUADyBARBySDXuvf1I8e6FiyZQ+mF7jQF1YzkWWRkxdIv61KgpvhTX4ncP3",
  render_errors: [view: CheerlandApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CheerlandApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Add support for microseconds at the DB level
# this avoids having to configure it on every migration file
config :cheerland_api, CheerlandApi.Repo, migration_timestamps: [type: :utc_datetime_usec]

# Guardian configuration
config :cheerland_api, CheerlandApiWeb.Guardian,
  issuer: "CheerlandApi",
  ttl: {1, :days},
  allowed_drift: 2000,
  secret_key: System.get_env("SECRET") || "Zq5AjKfcIqTCQn6WZhNGhAaBmhdAZCeKKFc9TSNZy6ts4tk3ymjEJbKpFwAYIdfr"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
