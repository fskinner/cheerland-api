defmodule CheerlandApi.Auth.AuthTest do
  use CheerlandApi.DataCase

  alias CheerlandApi.Auth

  describe "users" do
    alias CheerlandApi.Auth.User

    @valid_attrs %{
      allow_couple_bed: true,
      allowed_group: "some allowed_group",
      cancel_bus: true,
      departure_location: "some departure_location",
      departure_time: "some departure_time",
      email: "email@mail.com",
      password: "some password",
      gender: "some gender",
      is_admin: true,
      name: "some name",
      needs_transportation: true,
      reserved_at: ~D[2010-04-17]
    }
    @update_attrs %{
      allow_couple_bed: false,
      allowed_group: "some updated allowed_group",
      cancel_bus: false,
      departure_location: "some updated departure_location",
      departure_time: "some updated departure_time",
      email: "updated@mail.com",
      password: "some updated password",
      gender: "some updated gender",
      is_admin: false,
      name: "some updated name",
      needs_transportation: false,
      reserved_at: ~D[2011-05-18]
    }
    @invalid_attrs %{
      allow_couple_bed: nil,
      allowed_group: nil,
      cancel_bus: nil,
      departure_location: nil,
      departure_time: nil,
      email: nil,
      password: nil,
      gender: nil,
      is_admin: nil,
      name: nil,
      needs_transportation: nil,
      reserved_at: nil
    }

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Auth.create_user()

      user
    end

    defp compare_user_fields(user, attrs) do
      assert user.allow_couple_bed == attrs.allow_couple_bed
      assert user.allowed_group == attrs.allowed_group
      assert user.cancel_bus == attrs.cancel_bus
      # assert user.departure_location == attrs.departure_location
      # assert user.departure_time == attrs.departure_time
      assert user.email == attrs.email
      assert user.gender == attrs.gender
      assert user.is_admin == attrs.is_admin
      assert user.name == attrs.name
      assert user.needs_transportation == attrs.needs_transportation
      assert user.reserved_at == attrs.reserved_at
    end

    test "list_users/0 returns all users" do
      _user = user_fixture()
      assert Auth.list_users() |> List.first() |> compare_user_fields(@valid_attrs)
    end

    @valid_attrs.allowed_group

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Auth.get_user!(user.id) |> compare_user_fields(@valid_attrs)
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Auth.create_user(@valid_attrs)
      user |> compare_user_fields(@valid_attrs)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Auth.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Auth.update_user(user, @update_attrs)

      user |> compare_user_fields(@update_attrs)
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Auth.update_user(user, @invalid_attrs)
      assert compare_user_fields(user, Auth.get_user!(user.id))
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Auth.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Auth.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Auth.change_user(user)
    end
  end
end
