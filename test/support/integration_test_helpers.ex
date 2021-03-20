defmodule Phx.Gen.Saas.TestSupport.IntegrationTestHelpers do
  def setup_test_app(app_name, opts \\ []) do
    File.mkdir_p!(test_apps_path())
    test_app_path = Path.join(test_apps_path(), app_name)

    if File.exists?(test_app_path) do
      File.rm_rf!(test_app_path)
    end
    generate_new_phoenix_app(app_name, opts)
    test_app_path
  end

  defp project_root_path do
    Path.expand("../../", __DIR__)
  end

  defp test_apps_path do
    Path.expand("../../test_apps", __DIR__)
  end

  defp generate_new_phoenix_app(app_name, opts) when is_list(opts) do
    app_path = test_apps_path()
               |> Path.join(app_name)
               |> Path.relative_to(project_root_path())

    Mix.Task.run("phx.new", [app_path | opts])
  end
end
