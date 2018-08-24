use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :banzai, BanzaiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :banzai, Banzai.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("BANZAI_TEST_DB_USER"),
  password: System.get_env("BANZAI_TEST_DB_PASS"),
  database: "banzai_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
