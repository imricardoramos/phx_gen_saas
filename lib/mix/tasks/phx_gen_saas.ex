defmodule Mix.Tasks.Phx.Gen.Saas do
  use Mix.Task

  import Phx.Gen.Saas.TestSupport.IntegrationTestHelpers
  @shortdoc "Generates SaaS auxiliary services"
  def run(_) do
    test_app_path = setup_test_app("hello")
    copy_new_files(test_app_path)
  end


  defp copy_new_files(base_path) do
    files = files_to_be_generated(base_path, "hello")
    for {format, source_file, dest_file} <- files do
      case format do
        :eex -> Mix.Generator.copy_file("priv/templates/" <> source_file, dest_file)
      end
    end
  end

  defp files_to_be_generated(base_path, app_name) do
    web_prefix = Path.join([base_path, "lib", app_name <> "_web"])
    [
      {:eex, "login.html.eex", Path.join([web_prefix, "templates", "user", "login.html.eex"])},
      {:eex, "signup.html.eex", Path.join([web_prefix, "templates", "user", "signup.html.eex"])},
    ]
  end
end
