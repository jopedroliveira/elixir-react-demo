defmodule Heexreact.Repo do
  use Ecto.Repo,
    otp_app: :heexreact,
    adapter: Ecto.Adapters.SQLite3
end
