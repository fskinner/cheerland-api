defmodule CheerlandApi.Reservations.Room do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rooms" do
    field :description, :string
    field :group, :string
    field :label, :string
    field :max_beds, :integer
    field :photos_url, :string
    field :women_only, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(room, attrs) do
    room
    |> cast(attrs, [:label, :description, :max_beds, :women_only, :group, :photos_url])
    |> validate_required([:label, :description, :max_beds, :women_only, :group, :photos_url])
    |> unique_constraint(:label)
  end
end
