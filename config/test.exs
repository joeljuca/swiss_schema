import Config

config :swiss_schema, SwissSchemaTest, database_path: System.tmp_dir!() <> "test.sqlite"
