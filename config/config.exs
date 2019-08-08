# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_mediahub,
  namespace: MediaHub,
  ecto_repos: [MediaHub.Repo]

# Configures the endpoint
config :ex_mediahub, MediaHubWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Rmr/eOj7RlHqACooH63wRwd7rESdE9atju+yr4G5bn3ThKsuEdvC/lUU/9TO/esP",
  render_errors: [view: MediaHubWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MediaHub.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "tpZ0ZkN4rhnYYM0fdEFTXVNxAqgC68K1"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
