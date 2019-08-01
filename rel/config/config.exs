use Mix.Config

config :ex_mediahub, Mediahub.Repo,
  username: System.get_env("DATABASE_USER"),
  password: System.get_env("DATABASE_PASS"),
  database: System.get_env("DATABASE_NAME"),
  hostname: System.get_env("DATABASE_HOST"),
  pool_size: 15

port = String.to_integer(System.get_env("PORT") || "4000")

config :ex_mediahub, Mediahub.Endpoint,
  http: [port: port],
  url: [host: System.get_env("HOSTNAME"), port: port],
  root: ".",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :ex_mediahub, file_attachments_location: System.get_env("FILE_ATTACHMENTS_LOCATION")
config :ex_mediahub, course_path: System.get_env("COURSE_PATH")
config :ex_mediahub, mediahub_url: System.get_env("MEDIAHUB_URL")
