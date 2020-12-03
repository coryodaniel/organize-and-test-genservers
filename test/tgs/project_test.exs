defmodule Tgs.ProjectTest do
  use ExUnit.Case, async: true
  doctest Tgs.Project
  doctest Tgs.Project.Logic
  alias Tgs.Project.Repository

  test "create_project/2 creates a project", %{test: test} do
    # You can test here or in doctest...
    # By testing the API we are exercising the Server and Logic modules - and could consider
    # those private and not needing tests. YMMV.

    # We take the test name and use it as the server name, this creates isolation for our tests to run
    # async

    {:ok, server} = Tgs.Project.start_link(%Repository{}, name: test)

    Tgs.Project.create_project(server, "rails app")

    assert Tgs.Project.list_projects(server) == ["rails app"]
  end

  test "list_project/1 lists projects", %{test: test} do
    # You can test here or in doctest...
    # By testing the API we are exercising the Server and Logic modules - and could consider
    # those private and not needing tests. YMMV.

    # We take the test name and use it as the server name, this creates isolation for our tests to run
    # async
    {:ok, server} = Tgs.Project.start_link(%Repository{projects: ["phoenix app"]}, name: test)
    assert Tgs.Project.list_projects(server) == ["phoenix app"]
  end  
end

