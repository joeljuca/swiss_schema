import Config

if Mix.env() in [:dev, :test] do
  config :swiss_schema, :sqlite_database_path, "/tmp/swiss_schema_test.db"
end
