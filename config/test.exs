use Mix.Config

# Configure your database
config :ex_mediahub, MediaHub.Repo,
  username: "admin",
  password: "admin",
  database: "ex_mediahub_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ex_mediahub, MediaHubWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
