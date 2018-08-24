use Mix.Config

config :banzai, BanzaiWeb.Endpoint,
  http: [port: 8080],
  debug_errors: true,
  code_reloader: true,
  # ,
  check_origin: false,
  https: [
    port: 8443,
    keyfile: System.get_env("SSL_KEY_PATH"),
    certfile: System.get_env("SSL_CERT_PATH")
  ]

config :banzai, BanzaiWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/banzai_web/views/.*(ex)$},
      ~r{lib/banzai_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :banzai, Banzai.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("BANZAI_DB_USER"),
  password: System.get_env("BANZAI_DB_PASS"),
  database: System.get_env("BANZAI_DB_NAME"),
  hostname: System.get_env("BANZAI_DB_HOST"),
  pool_size: 10
