import Config

if Mix.env() == :test do
  config :swiss_schema, :database_dir, "/tmp/swiss_schema"
end
