defmodule Demo.Repo.Migrations.CreatePost do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :name, :string
      add :body, :text
      add :group_ids, {:array, :integer}

      timestamps()
    end
  end
end
