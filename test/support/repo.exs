defmodule SwissSchemaTest.Repo do
  @database_path Application.compile_env(:swiss_schema, SwissSchemaTest)
                 |> Keyword.fetch!(:database_path)

  use Ecto.Repo,
    otp_app: :swiss_schema,
    adapter: Ecto.Adapters.SQLite3,
    database: @database_path
end
