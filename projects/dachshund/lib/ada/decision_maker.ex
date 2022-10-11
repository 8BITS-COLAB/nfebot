defmodule ADA.DecisionMaker do
  require Logger
  alias ADA.Email.{Builder, Sender}

  def make(
        %{
          "action" => "sendMail",
          "userDescription" => description,
          "userMail" => email,
          "userName" => username,
          "userPhone" => phone
        },
        context
      ) do
    Builder.default(%{
      subject: "Need Contact",
      title: "Hi",
      description: description,
      to: %{
        name: username,
        email: email
      }
    })
    |> Sender.deliver_later!()

    Map.put(context["skills"]["main skill"], "user_defined", %{})
  end

  def make(_, context), do: context

  def make(
        %{
          "skills" => %{
            "main skill" => %{
              "user_defined" => user_defined
            }
          }
        } = context
      ) do
    make(user_defined, context)
  end

  def make(context), do: context
end
