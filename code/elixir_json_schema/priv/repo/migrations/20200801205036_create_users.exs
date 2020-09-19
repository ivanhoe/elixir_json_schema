defmodule ElixirJsonSchema.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do      
      add :is_active, :boolean, default: false, null: false
      add :email, :string, null: false
      add :password_hash, :string
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
