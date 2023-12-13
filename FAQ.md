# FAQ

Here I'll address some frequent questions I get asked when I introduce the project to Elixir developers.

## Why do I need a query toolkit?

> TL;DR: for idiomatic code. And convenience.

I started to work on SwissSchema after noticing that using CRUD functions out of Phoenix generators brings a maintenance burden I don't want to have.

Ecto also lacks an idiomatic API to query Ecto repositories. Writing code blocks like `Repo.get(User 123)` is just a bit verbose, it often needs a `case` block, etc.

SwissSchema tries to be a one-stop-shop for this type of issues.

## Why not just `mix phx.gen.schema`?

> TL;DR: context modules should hold transactional functions, not CRUDs.

The functions that Phoenix generates when you use `mix phx.gen.schema` to generate code is also more code for you to maintain yourself. I don't think it's wise to maintain such basic functions (eg: tests, docs, etc.) in each project we build. It just doesn't make sense.

Also, I think that context modules should not contain CRUD code. Context modules are supposed to be the entry point for inner functionality (aka: a [Facade](https://en.wikipedia.org/wiki/Facade_pattern)). So, moving these CRUD functions to a shared FOSS project allows context modules to focus on what they're supposed to do.

## Why SwissSchema does not implement function X?

Some functions in Ecto APIs are not tied to a schema, they accept queries instead (or something else that's not directly tied to a schema module). Implementing these functions might cause confusion, since their interfaces would differ from their Ecto equivalents (SwissSchema functions are always tied to a schema). It might even get developers confused by the API differences (eg: the Ecto one expects a query, but the SwissSchema one expects an ID, of a keyword list of params), so these are not getting equivalents in SwissSchema (at least not with the same names):

Below is a list of functions whose absence is enforced:

- [`exists?/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:exists?/2) (Ecto.Repo)

## Why license it under Apache License 2.0?

It's the same license used by [Elixir](https://elixir-lang.org).
