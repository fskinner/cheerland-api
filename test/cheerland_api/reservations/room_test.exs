defmodule CheerlandApi.Auth.RoomTest do
  use CheerlandApi.DataCase

  alias CheerlandApi.Reservations.Room

  @valid_attrs %{
    label: "First Room",
    max_beds: 5,
    women_only: false,
    group: "A"
  }


  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset, label too short " do
    changeset =
      Room.changeset(
        %Room{},
        Map.put(@valid_attrs, :label, "1")
      )

    refute changeset.valid?
  end

  test "changeset, label too long" do
    changeset =
      Room.changeset(
        %Room{},
        Map.put(@valid_attrs, :label, "01234567890123456789012345678901234567891")
      )

    refute changeset.valid?
  end

  test "changeset, max_beds too small" do
    changeset =
      Room.changeset(
        %Room{},
        Map.put(@valid_attrs, :max_beds, 0)
      )

    refute changeset.valid?
  end

  test "changeset, max_beds too much" do
    changeset =
      Room.changeset(
        %Room{},
        Map.put(@valid_attrs, :max_beds, 1001)
      )

    refute changeset.valid?
  end
end
