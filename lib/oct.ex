defmodule Oct do
  def deps(mix_deps \\ []) do
    Oct.Deps.read ++ mix_deps
  end
end
