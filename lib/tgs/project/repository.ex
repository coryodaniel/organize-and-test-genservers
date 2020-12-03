defmodule Tgs.Project.Repository do
  @moduledoc "The state / repository of this genserver"
  @type t :: %{projects: list(String.t())}
  defstruct projects: []
end