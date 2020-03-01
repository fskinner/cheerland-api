defmodule CheerlandApiWeb.Guardian do
  use Guardian, otp_app: :cheerland_api

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = CheerlandApi.Auth.get_user!(id)
    {:ok, resource}
  end
end
