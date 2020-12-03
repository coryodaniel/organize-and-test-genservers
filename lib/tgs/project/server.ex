defmodule Tgs.Project.Server do
  @moduledoc "The GenServer callbacks code. I consider more than 1 line in a Server to be a smell unless its a mutating handle_call"
  use GenServer
  alias Tgs.Project.Logic

  @impl true
  def init(repo), do: { :ok, repo }
  
  @impl true
  def handle_call(:list_projects, _from, repo), do:   { :reply, Logic.list_projects(repo), repo }
  
  @impl true
  def handle_cast({:create_project, name}, repo), do: { :noreply, Logic.create_project(repo, name) }

  @impl true
  def handle_call({:delete_project, name}, _from, %{projects: project} = repo) do
    updated_repo = Logic.delete_project(repo, name)
    { :reply, updated_repo, updated_repo }
  end
end