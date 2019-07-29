defmodule MediaHub.Repo do
  use Ecto.Repo,
    otp_app: :ex_mediahub,
    adapter: Ecto.Adapters.Postgres
end
