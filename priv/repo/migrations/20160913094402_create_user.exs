defmodule Demo.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :group_ids, {:array, :integer}

      timestamps()
    end
  end
end
