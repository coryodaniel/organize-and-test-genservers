defmodule Tgs.Project.Logic do
  @moduledoc "The 'business logic' of this genserver"
  alias Tgs.Project.Repository
  def new() do
    %Repository{}
  end

  @doc """
  Create a new project

  ## Example
      iex> Tgs.Project.Logic.create_project(%Tgs.Project.Repository{}, "rails app")
      %Tgs.Project.Repository{projects: ["rails app"]}
  """
  @spec create_project(Tgs.Project.Repository.t(), String.t()) :: map
  def create_project(%{projects: projects} = repo, name) do
    updated_projects = [name | projects]
    Map.put(repo, :projects, updated_projects)
  end

  @doc """
  List projects

  ## Example
      iex> Tgs.Project.Logic.list_projects(%Tgs.Project.Repository{projects: ["rails app"]})
      ["rails app"]
  """
  @spec list_projects(Tgs.Project.Repository.t()) :: list(String.t())
  def list_projects(%{projects: projects}), do: projects

  def delete_project(%{projects: projects} = repo, name) do
    update_projects = List.delete(projects, name)
    Map.put(repo, :projects, update_projects)
  end
end