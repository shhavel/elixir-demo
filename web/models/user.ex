# web/models/user.ex
defmodule Demo.User do
  use Demo.Web, :model

  schema "users" do
    field :name, :string
    field :group_ids, {:array, :integer}

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :group_ids])
    |> validate_required([:name, :group_ids])
  end
end
