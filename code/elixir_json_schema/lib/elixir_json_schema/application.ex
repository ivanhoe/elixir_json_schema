defmodule ElixirJsonSchema.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  
  def start(_type, _args) do
    import Supervisor.Spec

    opts =
    [
      host: "datadog",
      port:  8126,
      batch_size:  1,
      sync_threshold:  10,
      http: HTTPoison
    ]

    # List all child processes to be supervised
    children = [

      worker(SpandexDatadog.ApiServer, [opts]),
      # Start the Ecto repository
      ElixirJsonSchema.Repo,
      # Start the endpoint when the application starts
      ElixirJsonSchemaWeb.Endpoint
      # Starts a worker by calling: ElixirJsonSchema.Worker.start_link(arg)
      # {ElixirJsonSchema.Worker, arg},
    ]

    :ok =
      :telemetry.attach(
        "spandex-query-tracer",
        [:elixir_json_schema, :repo_elixir_json_schema, :query],
        &SpandexEcto.TelemetryAdapter.handle_event/4,
        nil
      )

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ElixirJsonSchema.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    ElixirJsonSchemaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
