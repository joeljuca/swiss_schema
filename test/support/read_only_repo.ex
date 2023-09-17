defmodule SwissSchemaTest.ReadOnlyRepo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :swiss_schema,
    adapter: Ecto.Adapters.SQLite3,
    database: Application.compile_env!(:swiss_schema, :sqlite_database_path),
    read_only: true
end
