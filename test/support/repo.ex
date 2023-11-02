defmodule SwissSchemaTest.Repo do
  @moduledoc false
  @database_dir Application.compile_env!(:swiss_schema, :database_dir)
  use Ecto.Repo,
    otp_app: :swiss_schema,
    adapter: Ecto.Adapters.SQLite3,
    database: "#{@database_dir}/repo.db"
end

defmodule SwissSchemaTest.Repo2 do
  @moduledoc false
  @database_dir Application.compile_env!(:swiss_schema, :database_dir)
  use Ecto.Repo,
    otp_app: :swiss_schema,
    adapter: Ecto.Adapters.SQLite3,
    database: "#{@database_dir}/repo2.db"
end
