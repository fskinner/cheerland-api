defmodule CheerlandApiWeb.RoomView do
  use CheerlandApiWeb, :view
  alias CheerlandApiWeb.RoomView

  def render("index.json", %{rooms: rooms}) do
    %{data: render_many(rooms, RoomView, "room.json")}
  end

  def render("show.json", %{room: room}) do
    %{data: render_one(room, RoomView, "room.json")}
  end

  def render("room.json", %{room: room}) do
    %{
      id: room.id,
      label: room.label,
      description: room.description,
      max_beds: room.max_beds,
      women_only: room.women_only,
      group: room.group,
      photos_url: room.photos_url
    }
  end
end
