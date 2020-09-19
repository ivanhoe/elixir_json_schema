# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_json_schema,
  ecto_repos: [ElixirJsonSchema.Repo]

# Configures the endpoint
config :elixir_json_schema, ElixirJsonSchemaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "C5Sti3wdY7zAc/4NltOm6VpuhnFCvrIHRY/i0YeuV0JNhVqbdI+7gpJjk0YsWkHM",
  render_errors: [view: ElixirJsonSchemaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ElixirJsonSchema.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
