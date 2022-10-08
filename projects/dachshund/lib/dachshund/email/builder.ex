defmodule Malamute.Email.Builder do
  alias Malamute.Email.Views.LayoutView
  use Bamboo.Template, view: LayoutView

  def build({template, context}) do
    base_email()
    |> subject(context.subject)
    |> to({context.to.name, context.to.email})
    |> render(template, context)
  end

  defp base_email() do
    new_email()
    |> from({"Malamute", "malamute.mailer@gmail.com"})
    |> put_html_layout({LayoutView, "email.html"})
  end
end
