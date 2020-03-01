defmodule CheerlandApi.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias CheerlandApi.Reservations.Room

  schema "users" do
    field :allow_couple_bed, :boolean, default: false
    field :allowed_group, :string
    field :cancel_bus, :boolean, default: false
    field :departure_location, :string
    field :departure_time, :string
    field :email, :string
    field :encrypted_password, :string
    field :gender, :string
    field :is_admin, :boolean, default: false
    field :name, :string
    field :needs_transportation, :boolean, default: false
    field :reserved_at, :date

    belongs_to(:room, Room)

    field(:password, :string, virtual: true)

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :email,
      :name,
      :password,
      :gender,
      :reserved_at,
      :needs_transportation,
      :room_id,
      :is_admin,
      :allowed_group,
      :allow_couple_bed,
      :cancel_bus,
      :departure_location,
      :departure_time,
      :cancel_bus
    ])
    |> validate_required([
      :email,
      :name,
      :password,
      :gender,
      :needs_transportation,
      :allowed_group
    ])
    |> validate_length(:email, min: 5, max: 150)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6)
    |> unique_constraint(:email, message: "Email already taken")
    |> assoc_constraint(:room)
    |> put_encrypted_password
  end

  defp put_encrypted_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :encrypted_password, Bcrypt.hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
