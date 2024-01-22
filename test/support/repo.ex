defmodule SwissSchemaTest.Repo do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :swiss_schema,
    adapter: Ecto.Adapters.Postgres,
    show_sensitive_data_on_connection_error: true,
    stacktrace: true
end

defmodule SwissSchemaTest.Repo2 do
  @moduledoc false

  use Ecto.Repo,
    otp_app: :swiss_schema,
    adapter: Ecto.Adapters.Postgres,
    show_sensitive_data_on_connection_error: true,
    stacktrace: true
end
