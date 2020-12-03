# How I test and layout genservers

## Set up and run tests & type checks

I tested a few different ways:

*DocTests on the public API of the GenServer (`lib/project.ex`)*

I like to consider my modules in the public API's directory to be "semi private" and test from the public interface.

I use dependency injection to put in the state, and I start a named instances of the GenServer for test isolation so tests can be async.

This validates the public API works as documented.

*ExUnit tests on the public API `test/tgs/project_test.exs`*

Similar to the tests in DocTest, but I use the exunit test ID as the genserver name.

This lets you have more involved tests that via DocTest, but then it doesn't validate the documentation. YMMV.

*DocTests on the functional logic of the GenServer (`lib/tgs/project/logic.ex`)

I don't like this since its a "semi private" model, but some people appreciate the functional tests without involving a genserver.

## How I layout GenServers

* `lib/project.ex` - Public API for the genserver
* `lib/project/logic.ex` - The business logic of the feature
* `lib/project/repository.ex` - The struct and type for the state of the genserver
* `lib/project/server.ex` - The genserver callback code

I consider any genserver callback a smell if its more than a single line of code, because all of the logic should be in `logic.ex`, except when doing a mutating `handle_call/3`.


```shell
mix deps.get

mix test --cover
mix dialyzer
```

## Interact w/ project storage

Run `iex -S mix`:

```elixir
{:ok, project} = Tgs.Project.start_link()
Tgs.Project.list_projects(project)
Tgs.Project.create_project(project, "my project")
```