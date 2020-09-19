defmodule ElixirJsonSchemaWeb.UserHelper do
  @schema_path "/priv/schemas/user_schema.json"

  # Carga un json guardado en priv/schemas/credit_repair_schema.json
  # para validar el esquema del objecto
  @spec load_credit_repair_schema() :: struct
  def load_credit_repair_schema() do
    path = Application.app_dir(:elixir_json_schema) <> @schema_path

    path
    |> File.read!()
    |> Poison.decode!()
    |> ExJsonSchema.Schema.resolve()
  end

    # Valida la información contra el esquema del object
    @spec validate_credit_repair_schema(map) :: tuple
    def validate_credit_repair_schema(data) do
      schema = load_credit_repair_schema()
  
      with :ok <- ExJsonSchema.Validator.validate(schema, data) do
        {:ok, data}
      else
        {:error, error_list} ->
          {:error, error_list}
      end
    end

    def handle_errors(data, errors) do
        schema_errors =
          Enum.reduce(
            errors,
            %{},
            fn {error, description}, acc ->
              Map.update(
                acc,
                error,
                [description],
                fn desc -> [description | desc] end
              )
            end
          )
    end

end


  

