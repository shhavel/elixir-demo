# web/models/post.ex
defmodule Demo.Post do
  use Demo.Web, :model

  schema "posts" do
    field :name, :string
    field :body, :string
    field :group_ids, {:array, :integer}

    timestamps
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :body, :group_ids])
    |> validate_required([:name, :body, :group_ids])
  end

  def accessible_by(query, user) do
    from p in query, where: fragment("? && ?", p.group_ids, ^user.group_ids)
  end
end
