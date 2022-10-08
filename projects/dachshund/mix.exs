defmodule Malamute.MixProject do
  use Mix.Project

  def project do
    [
      app: :malamute,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [
        :logger,
        :ex_twilio,
        :ex_twiml,
        :plug_cowboy,
        :poison,
        :bamboo,
        :bamboo_smtp
      ],
      mod: {Malamute.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_twilio, "~> 0.9.1"},
      {:ex_twiml, "~> 2.1"},
      {:plug_cowboy, "~> 2.5"},
      {:poison, "~> 5.0"},
      {:bamboo, "~> 2.2"},
      {:bamboo_smtp, "~> 4.2"}
    ]
  end
end
