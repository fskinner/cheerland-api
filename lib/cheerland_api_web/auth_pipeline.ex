defmodule CheerlandApiWeb.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :todo_with_auth,
    module: CheerlandApiWeb.Guardian,
    error_handler: CheerlandApiWeb.Guardian.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.EnsureAuthenticated)

  # check this afterwards
  plug(Guardian.Plug.LoadResource)
end
