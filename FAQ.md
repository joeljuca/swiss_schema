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

## Why license it under Apache License 2.0?

It's the same license used by [Elixir](https://elixir-lang.org).
