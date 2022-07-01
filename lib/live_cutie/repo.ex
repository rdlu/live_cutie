defmodule LiveCutie.Repo do
  use Ecto.Repo,
    otp_app: :live_cutie,
    adapter: Ecto.Adapters.Postgres
end
