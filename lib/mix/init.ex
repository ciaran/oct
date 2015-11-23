defmodule Mix.Tasks.Oct.Init do
  use Mix.Task

  def run(_args) do
    case File.stat("Octfile") do
      {:ok, %{size: size}} when size > 0
        -> Mix.raise "Octfile already exists and is not empty"
      _ ->
        deps = Mix.Project.config[:deps]
        Oct.Deps.write!(deps)
        IO.puts("Created new Octfile with #{length deps} existing dependencies")
    end
  end
end
