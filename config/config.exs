import Config

if Mix.env() in [:dev, :test] do
  config :swiss_schema,
         :sqlite_database_path,
         Path.join([System.get_env("TMPDIR"), "swiss_schema_test.db"])
end
