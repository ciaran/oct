defmodule Oct.Deps do
  defp lines_to_deps([""]), do: []

  defp lines_to_deps(lines) do
    lines
    |> Enum.map(fn(line) ->
      [ name, version ] = String.split(line, ~r{\s*,\s*})
      { String.to_atom(name), version }
    end)
  end

  def read do
    case File.read("Octfile") do
      { :ok, deps } ->
        deps
        |> String.strip
        |> String.split("\n")
        |> lines_to_deps
      { :error, _error } ->
        []
    end
  end

  def deps_to_string(deps) do
    Enum.map_join(deps, "\n", fn({ name, version }) ->
      to_string(name) <> ", " <> version
    end) <> "\n"
  end

  def write!(list) do
    case File.open("Octfile", [:write]) do
      {:ok, file} ->
        IO.write(file, deps_to_string(list))
      {:error, _} -> Mix.raise "Couldn't open file for write"
    end
  end

  def append!(package) do
    read ++ package |> write!
  end
end
