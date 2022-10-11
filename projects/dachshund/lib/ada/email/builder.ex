defmodule ADA.Email.Builder do
  alias ADA.Email.LayoutView
  use Bamboo.Template, view: LayoutView

  def default(context) do
    base_email()
    |> subject(context.subject)
    |> to({context.to.name, context.to.email})
    |> render("email.html", context)
  end

  defp base_email(), do: from(new_email(), {"ADA", "ada.mailer@gmail.com"})
end
