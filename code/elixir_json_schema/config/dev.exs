use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :elixir_json_schema, ElixirJsonSchemaWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "node_modules/webpack/bin/webpack.js",
      "--mode",
      "development",
      "--watch-stdin",
      cd: Path.expand("../assets", __DIR__)
    ]
  ],
  instrumenters: [SpandexPhoenix.Instrumenter]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :elixir_json_schema, ElixirJsonSchemaWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/elixir_json_schema_web/views/.*(ex)$},
      ~r{lib/elixir_json_schema_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, 
  #format: "[$level] $message\n",
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :pid, :trace_id, :span_id]

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

# Configure your database
config :elixir_json_schema, ElixirJsonSchema.Repo,
  username: "postgres",
  password: "postgres",
  database: "elixir_json_schema_dev",
  hostname: "localhost",
  pool_size: 10

config :elixir_json_schema, ElixirJsonSchema.Tracer,
  adapter: SpandexDatadog.Adapter,
  service: :phoenix_backend_elixir_json,  
  type: :web    

config :spandex_phoenix, tracer: ElixirJsonSchema.Tracer

config :spandex_ecto, SpandexEcto.EctoLogger,
  service: :phoenix_backend_ecto,
  tracer: ElixirJsonSchema.Tracer,
  otp_app: :elixir_json_schema