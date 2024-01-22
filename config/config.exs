# This file is dev/test only, and is not included in SwissSchema releases

import Config

config :swiss_schema,
  ecto_repos: [SwissSchemaTest.Repo, SwissSchemaTest.Repo2]

config :swiss_schema, SwissSchemaTest.Repo,
  hostname: System.get_env("POSTGRES_HOSTNAME") || "localhost",
  username: System.get_env("POSTGRES_USERNAME") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "repo"

config :swiss_schema, SwissSchemaTest.Repo2,
  hostname: System.get_env("POSTGRES_HOSTNAME") || "localhost",
  username: System.get_env("POSTGRES_USERNAME") || "postgres",
  password: System.get_env("POSTGRES_PASSWORD") || "postgres",
  database: "repo2"
