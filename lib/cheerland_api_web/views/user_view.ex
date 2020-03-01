defmodule CheerlandApiWeb.UserView do
  use CheerlandApiWeb, :view
  alias CheerlandApiWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      email: user.email,
      name: user.name,
      encrypted_password: user.encrypted_password,
      gender: user.gender,
      reserved_at: user.reserved_at,
      needs_transportation: user.needs_transportation,
      departure_location: user.departure_location,
      departure_time: user.departure_time,
      is_admin: user.is_admin,
      allowed_group: user.allowed_group,
      cancel_bus: user.cancel_bus,
      allow_couple_bed: user.allow_couple_bed
    }
  end
end
