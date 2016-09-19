defmodule Demo.PostTest do
  use Demo.ModelCase

  alias Demo.{Post, Group, User}

  @valid_attrs %{body: "some content", name: "some content", group_ids: []}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Post.changeset(%Post{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Post.changeset(%Post{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "accessible for user" do
    g1 = %Group{} |> Repo.insert!
    g2 = %Group{} |> Repo.insert!
    g3 = %Group{} |> Repo.insert!

          %Post{group_ids: [g1.id]} |> Repo.insert!
    p21 = %Post{group_ids: [g2.id, g1.id]} |> Repo.insert!
    p22 = %Post{group_ids: [g2.id]} |> Repo.insert!
    p31 = %Post{group_ids: [g3.id]} |> Repo.insert!

    user = %User{group_ids: [g2.id, g3.id]} |> Repo.insert!

    post_ids = Post
    |> Post.accessible_by(user)
    |> Ecto.Query.order_by(:id)
    |> Repo.all
    |> Enum.map(&(&1.id))

    assert post_ids == [p21.id, p22.id, p31.id]
  end
end
