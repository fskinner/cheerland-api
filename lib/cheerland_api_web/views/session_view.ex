defmodule CheerlandApiWeb.SessionView do
  use CheerlandApiWeb, :view

  def render("token.json", %{token: token}) do
    %{token: token}
  end
end
