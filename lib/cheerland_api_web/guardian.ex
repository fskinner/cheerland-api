defmodule CheerlandApiWeb.Guardian do
  use Guardian, otp_app: :cheerland_api

  def subject_for_token(resource, _claims) do
    sub = Jason.encode!(%{
      id: resource.id,
      email: resource.email,
      name: resource.name,
      gender: resource.gender,
      is_admin: resource.is_admin,
    })
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = CheerlandApi.Auth.get_user!(id)
    {:ok, resource}
  end
end
