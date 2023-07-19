defmodule SwissSchemaTest.Repo do
  use Ecto.Repo,
    otp_app: :swiss_schema,
    adapter: Ecto.Adapters.SQLite3,
    database: Application.compile_env!(:swiss_schema, :sqlite_database_path)
end
