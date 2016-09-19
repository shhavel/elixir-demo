defmodule Demo.Repo.Migrations.AddIndexOnGroupIds do
  use Ecto.Migration

  def up do
    # https://www.postgresql.org/docs/9.4/static/intarray.html
    # https://www.postgresql.org/docs/9.4/static/functions-array.html
    execute "CREATE EXTENSION IF NOT EXISTS intarray;"
    execute "CREATE INDEX users_group_ids_rdtree_index ON users USING GIST (group_ids gist__int_ops);"
    execute "CREATE INDEX posts_group_ids_rdtree_index ON posts USING GIST (group_ids gist__int_ops);"
  end

  def down do
    execute "DROP INDEX users_group_ids_rdtree_index;"
    execute "DROP INDEX posts_group_ids_rdtree_index;"
  end
end
