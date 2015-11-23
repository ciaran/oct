defmodule Mix.Tasks.Oct.Install do
  use Mix.Task

  def package_info(package) do
    Hex.start

    case Hex.API.Package.get(package) do
      {code, body} when code in 200..299 ->
        body
      {404, _} ->
        Hex.Shell.error "No package with name #{package}"
      {code, body} ->
        Hex.Shell.error "Failed to retrieve package information"
        Hex.Utils.print_error_result(code, body)
    end
  end

  def install_release(package, version) do
    Oct.Deps.append!([{package, version}])
    Hex.Shell.info "Run mix deps.get to fetch new packages"
  end

  def install_latest(package) do
    release = package_info(package) |> Dict.get("releases") |> Enum.at(0)
    Hex.Shell.info "Found #{package} version #{release["version"]}"
    install_release(package, release["version"])
  end

  def run(args) do
    case args do
      [package] ->
        install_latest(package)
      [package, version] ->
        install_release(package, version)
      _ ->
        Mix.raise "Missing package name, expected: mix oct.install PACKAGE [VERSION]"
    end
  end
end
