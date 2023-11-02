import Config

if Mix.env() in [:dev, :test] do
  config :swiss_schema, :database_dir, "/tmp/swiss_schema"
end
