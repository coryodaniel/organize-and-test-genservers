defmodule Tgs.Project do
  @moduledoc "This is the 'API' the rest of the application interfaces with."
  alias Tgs.Project.Server
  alias Tgs.Project.Repository
  require Logger

  @doc "Default function to create a Project server with an empty repository named Tgs.Project"
  def start_link() do
    start_link(%Repository{})
  end

  @doc "Control over initial repository and naming. Support for multiple Project servers and testing dependency injection"
  def start_link(repo, opts \\ []) do
    Logger.debug "Started with #{inspect(opts)}"
    name = Keyword.get(opts, :name, __MODULE__)
    GenServer.start_link(Server, repo, name: name)
  end
  
  @doc """
  Create a project
  
  ## Examples
      iex> {:ok, server} = Tgs.Project.start_link(%Tgs.Project.Repository{}, name: :create_project_test)
      ...> Tgs.Project.create_project(server, "foo bar")
      ...> Tgs.Project.list_projects(server)
      ["foo bar"]
  """
  def create_project(server, project) do
    GenServer.cast(server, {:create_project, project})
  end

  @doc """
  Create a project
  
  ## Examples
      iex> {:ok, server} = Tgs.Project.start_link(%Tgs.Project.Repository{projects: ["bar foo"]}, name: :list_projects_test)
      ...> Tgs.Project.list_projects(server)
      ["bar foo"]
  """
  def list_projects(server) do
    GenServer.call(server, :list_projects)
  end
end  