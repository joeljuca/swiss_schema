# SwissSchema

[![Licensed under Apache 2.0](https://img.shields.io/hexpm/l/swiss_schema)](license)
[![Hex version](https://img.shields.io/hexpm/v/swiss_schema)](https://hex.pm/packages/swiss_schema)
[![Quality status](https://github.com/joeljuca/swiss_schema/actions/workflows/quality.yml/badge.svg)](https://github.com/joeljuca/swiss_schema/actions/workflows/quality.yml)

**A Swiss Army knife for your Ecto schemas**

SwissSchema is a query toolkit for Ecto schemas. It makes it easy to manipulate data using Ecto schemas by implementing relevant Ecto.Repo [Query API](https://hexdocs.pm/ecto/Ecto.Repo.html#query-api) and [Schema API](https://hexdocs.pm/ecto/Ecto.Repo.html#schema-api) functions, pre-configured to work specifically with the given Ecto schema.

## Setup

Add `swiss_schema` as a dependency in `mix.exs`:

```elixir
def deps do
  [
    # ...
    {:swiss_schema, "~> 0.4"}
  ]
end
```

Then, `use SwissSchema` in your Ecto schemas:

```elixir
# lib/my_app/accounts/user.ex

defmodule MyApp.Accounts.User do
  use Ecto.Schema
  use SwissSchema, repo: MyApp.Repo
end
```

That's it, you should be good to go.

## Usage

When you `use SwissSchema`, a collection of pre-configured functions will be added to your Ecto schema module. The functions are equivalent to two important Ecto.Repo APIs: the [Query API](https://hexdocs.pm/ecto/Ecto.Repo.html#query-api) and the [Schema API](https://hexdocs.pm/ecto/Ecto.Repo.html#schema-api).

```elixir
iex> User.get(1)
{:ok, %User{id: 1, ...}}

iex> User.get_by(email: "john@smiths.net")
{:ok, %User{id: 2, email: "john@smiths.net", ...}}
```

The motivation to have such API directly in your Ecto schema is to make function calls more idiomatic.

[Check the docs](https://hexdocs.pm/swiss_schema) for a complete list of available functions.

## Alternatives

It seems that I'm not the only person in the world trying to improve this immediate Ecto's querying DX. Recently, I found some other projects similar to SwissSchema that creates some sort of querying tools out of Ecto schemas:

- **[Bee](https://hex.pm/packages/bee)** by [Helder de Sousa](https://github.com/andridus) ([GitHub](https://github.com/andridus/bee)) 🇧🇷
- **[EctoQuerify](https://hex.pm/packages/ecto_querify)** by [Marko Bogdanović](https://github.com/bmarkons) ([GitHub](https://github.com/bmarkons/ecto_querify)) 🇷🇸

## License

[Apache License 2.0](LICENSE)
