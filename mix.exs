defmodule Oct.Mixfile do
  use Mix.Project

  def project do
    [app: :oct,
     version: "0.0.1",
     elixir: "~> 1.1",
     aliases: aliases,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     preferred_cli_env: [install: :prod],
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  def aliases do
    [
      install: ["archive.build -o oct.ez", "archive.install oct.ez --force"],
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    []
  end
end
