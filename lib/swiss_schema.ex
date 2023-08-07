defmodule SwissSchema do
  @moduledoc """
  `SwissSchema` is a query toolkit for Ecto schemas. It makes it easy to manipulate data using Ecto schemas by implementing relevant Ecto.Repo [Query API](https://hexdocs.pm/ecto/Ecto.Repo.html#query-api) and [Schema API](https://hexdocs.pm/ecto/Ecto.Repo.html#schema-api) functions, pre-configured to work specifically with the given Ecto schema.

  ## Setup

  Add `swiss_schema` as a dependency in `mix.exs`:

      def deps do
      [
        # ...
        {:swiss_schema, "~> 0.4"}
      ]
      end

  Then, `use SwissSchema` in your Ecto schemas:

      # lib/my_app/accounts/user.ex

      defmodule MyApp.Accounts.User do
        use Ecto.Schema
        use SwissSchema, repo: MyApp.Repo
      end

  That's it, you should be good to go.

  ## Usage

  After setting up SwissSchema in your Ecto schema, there isn't much else to do. Just use the available functions now available in your own schema module:

      iex> alias MyApp.Accounts.User

      iex> User.all()
      []

      iex> User.create(%{name: "John Smith", email: "john@smiths.net"})
      {:ok, %User%{name: "John Smith", ...}}

      iex> User.all()
      [%User%{name: "John Smith", ...}]

  `SwissSchema` functions tries to mimic the Ecto.Repo's Query and Repo APIs by acting as a thin, pre-configured interface for Ecto.Repo callbacks.

  > #### Note {: .info}
  >
  > To keep examples short and simple, we use the example module from the previous section, `MyApp.Accounts.User`, in the functions documentation. So, when reading the docs for SwissSchema functions, assume the following alias was previously set up:
  >
  >     alias MyApp.Accounts.User
  >
  > So, the module `MyApp.Accounts.User` itself will be referred to just as `User`.
  """

  @doc """
  Calculate the given aggregation.

  ## Examples

      # Returns the number of users
      User.aggregate(:count)

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback aggregate(
              type :: :count,
              opts :: Keyword.t()
            ) :: term() | nil

  @doc """
  Calculate the given `aggregate` over the given `field`.

  ## Examples

      # Returns the sum of the number of visits for every user
      User.aggregate(:sum, :visits)

      # Returns the average number of user visits
      User.aggregate(:avg, :visits)

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback aggregate(
              type :: :avg | :count | :max | :min | :sum,
              field :: atom(),
              opts :: Keyword.t()
            ) :: term() | nil

  @doc """
  Fetches all entries from the respective data store.

  ## Example

      # Fetch all users
      User.all()

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback all(opts :: Keyword.t()) :: [Ecto.Schema.t() | term()]

  @callback create(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback create!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @doc """
  Deletes a struct using its primary key.

  If the struct has no primary key, `Ecto.NoPrimaryKeyFieldError`
  will be raised. If the struct has been removed prior to the call,
  `Ecto.StaleEntryError` will be raised. If more than one database
  operation is required, they're automatically wrapped in a transaction.

  It returns `{:ok, struct}` if the struct has been successfully
  deleted or `{:error, changeset}` if there was a validation
  or a known constraint error.

  ## Options

    * `:stale_error_field` - The field where stale errors will be added in
      the returning changeset. This option can be used to avoid raising
      `Ecto.StaleEntryError`.

    * `:stale_error_message` - The message to add to the configured
      `:stale_error_field` when stale errors happen, defaults to "is stale".

  ## Example

      user = User.get!(42)
      case User.delete post do
        {:ok, struct}       -> # Deleted with success
        {:error, changeset} -> # Something went wrong
      end

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Schema API"
  @callback delete(
              schema :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Same as `c:delete/2` but returns the struct or raises if the changeset is invalid.
  """
  @doc group: "Schema API"
  @callback delete!(
              schema :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @doc """
  Deletes all entries.

  It returns a tuple containing the number of entries and any returned
  result as second element. The second element is `nil` by default
  unless a `select` is supplied. Note, however, not all databases support
  returning data from DELETEs.

  ## Examples

      User.delete_all()

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback delete_all(opts :: Keyword.t()) :: {non_neg_integer(), nil | [term()]}

  @doc """
  Fetches an entry by the primary key from the data store.

  Returns `nil` if no entry was found. If the schema has no or more than one
  primary key, it will raise an argument error.

  ## Example

      User.get(42)

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback get(
              id :: term(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}

  @doc """
  Similar to `c:get/2` but raises `Ecto.NoResultsError` if no entry was found.

  ## Example

      User.get!(42)

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback get!(
              id :: term(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()

  @doc """
  Fetches a single entry from the data store.

  Returns `nil` if no result was found. Raises if more than one entry.

  ## Example

      User.get_by(email: "john@smiths.net")

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback get_by(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}

  @doc """
  Similar to `c:get_by/2` but raises `Ecto.NoResultsError` if no entry was found.

  Raises if more than one entry.

  ## Example

      User.get_by!(title: "john@smiths.net")

  See the ["Usage"](#module-usage) section for context info.
  """
  @doc group: "Query API"
  @callback get_by!(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()

  @doc """
  Inserts a new entry into the data store.

  Accepts a map with key-values matching respective schema fields.

  It returns `{:ok, struct}` if the map has been successfully inserted, or
  `{:error, changeset}` if there was a validation or a known constraint error.

  ## Options

    * `:returning` - selects which fields to return. It accepts a list of
      fields to be returned from the database. When `true`, returns all fields.
      When `false`, no extra fields are returned. It will always include all
      fields in `read_after_writes` as well as any autogenerated ID. Not all
      databases support this option and it may not be available during upserts.
      See the ["Upserts"](#module-upserts) section for more information.

    * `:on_conflict` - It may be one of `:raise` (the default), `:nothing`,
      `:replace_all`, `{:replace_all_except, fields}`, `{:replace, fields}`,
      a keyword list of update instructions or an `Ecto.Query` query for updates.
      See the ["Upserts"](#module-upserts) section for more information.

    * `:conflict_target` - A list of column names to verify for conflicts.
      It is expected those columns to have unique indexes on them that may
      conflict. If none is specified, the conflict target is left up to the
      database. It may also be `{:unsafe_fragment, binary_fragment}` to pass
      any expression to the database without any sanitization, this is useful
      for partial index or index with expressions, such as
      `{:unsafe_fragment, "(coalesce(firstname, ""), coalesce(lastname, "")) WHERE middlename IS NULL"}`
      for `ON CONFLICT (coalesce(firstname, ""), coalesce(lastname, "")) WHERE middlename IS NULL`
      SQL query.

    * `:stale_error_field` - The field where stale errors will be added in the
      returning changeset. This option can be used to avoid raising
      `Ecto.StaleEntryError`.

    * `:stale_error_message` - The message to add to the configured
      `:stale_error_field` when stale errors happen, defaults to "is stale".

  ## Examples

  A typical example is calling `User.insert/1` with a map and acting on the
  return value:

      case User.insert(%{name: "John S.", email: "john@smiths.net"}) do
        {:ok, user}         -> # Inserted with success
        {:error, changeset} -> # Something went wrong
      end

  ## Upserts

  `c:insert/2` provides upserts (update or inserts) via the `:on_conflict`
  option. The `:on_conflict` option supports the following values:

    * `:raise` - raises if there is a conflicting primary key or unique index

    * `:nothing` - ignores the error in case of conflicts

    * `:replace_all` - replace all values on the existing row with the values
      in the params map, including fields not explicitly set in the changeset,
      such as IDs and autogenerated timestamps (`inserted_at` and `updated_at`).
      Do not use this option if you have auto-incrementing primary keys, as they
      will also be replaced. You most likely want to use `{:replace_all_except, [:id]}`
      or `{:replace, fields}` explicitly instead.

    * `{:replace_all_except, fields}` - same as above except the given fields are
      not replaced.

    * `{:replace, fields}` - replace only specific columns. This option requires
      `:conflict_target`.

    * a keyword list of update instructions - such as the one given to
      `c:update_all/2`, for example: `[set: [title: "new title"]]`

    * an `Ecto.Query` that will act as an `UPDATE` statement, such as the
      one given to `c:update_all/2`. Similarly to `c:update_all/2`, auto-generated
      values, such as timestamps are not automatically updated.

      If the entry cannot be found, `Ecto.StaleEntryError` will be raised.

  Upserts map to `ON CONFLICT` on databases like Postgres and `ON DUPLICATE KEY`
  on databases such as MySQL.

  As an example, imagine `:email` is marked as a unique column in the database:

      {:ok, inserted} = User.insert(%{name: "John S.", email; "john@smiths.net"})

  Now we can insert with the same email but do nothing on conflicts:

      {:ok, ignored} = User.insert(%{email; "john@smiths.net"}, on_conflict: :nothing)

  Because we used `on_conflict: :nothing`, instead of getting an error,
  we got `{:ok, struct}`. However the returned struct does not reflect
  the data in the database. If the primary key is auto-generated by the
  database, the primary key in the `ignored` record will be nil if there
  was no insertion. For example, if you use the default primary key
  (which has name `:id` and a type of `:id`), then `ignored.id` above
  will be nil if there was no insertion.

  If your ID is generated by your application (typically the case for
  `:binary_id`) or if you pass another value for `:on_conflict`, detecting
  if an insert or update happened is slightly more complex, as the database
  does not actually inform us what happened. Let's insert a post with the
  same title but use a query to update the body column in case of conflicts:

      # In Postgres (it requires the conflict target for updates):
      on_conflict = [set: [bio: "updated"]]
      {:ok, updated} = User.insert(%User{username: "other_username"},
                                     on_conflict: on_conflict, conflict_target: :title)

      # In MySQL (conflict target is not supported):
      on_conflict = [set: [bio: "updated"]]
      {:ok, updated} = User.insert(%User{id: inserted.id, username: "another_username"},
                                     on_conflict: on_conflict)

  In the examples above, even though it returned `:ok`, we do not know if we
  inserted new data or if we updated only the `:on_conflict` fields. In case an
  update happened, the data in the struct most likely does not match the data
  in the database. For example, auto-generated fields such as `inserted_at`
  will point to now rather than the time the entry was actually inserted.

  If you need to guarantee the data in the returned struct mirrors the
  database, you have three options:

    * Use `on_conflict: :replace_all`, although that will replace all fields in
    the database with the ones in the params map, including auto-generated
    fields such as `inserted_at` and `updated_at`:

        %User{username: "new_username"}
        |> User.insert(on_conflict: :replace_all, conflict_target: :title)

    * Specify `read_after_writes: true` in your schema fields for choosing
      fields that are read from the database after every operation. Or pass
      `returning: true` to `c:insert/2` to read all fields back.

      Note that it will only read from the database if at least one field is
      updated.

          %User{username: "new_username"}
          |> User.insert(returning: true, on_conflict: on_conflict, conflict_target: :title)

    * Alternatively, read the data again from the database in a separate query.
    This option requires the primary key to be generated by the database:

          {:ok, %User{id: user_id}} = User.insert(%User{username: "new_username"}, on_conflict: on_conflict)
          {:ok, user} = User.get(user_id)

  Because of the inability to know if the struct is up to date or not, inserting
  an entry with associations and using the `:on_conflict` option at the same
  time is not recommended, as Ecto will be unable to actually track the proper
  status of the association.
  """
  @doc group: "Schema API"
  @callback insert(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback insert!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback insert_all(
              entries :: [%{required(atom()) => term()}] | Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}

  @callback insert_or_update(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback insert_or_update!(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback stream(opts :: Keyword.t()) :: Enum.t()

  @callback update(
              schema :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback update!(
              schema :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback update_all(
              updates :: Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}

  defmacro __using__(opts) do
    repo = Keyword.fetch!(opts, :repo)

    quote do
      @behaviour SwissSchema

      @impl SwissSchema
      def aggregate(type, opts \\ [])

      def aggregate(:count, opts) when is_list(opts) do
        unquote(repo).aggregate(__MODULE__, :count, opts)
      end

      def aggregate(type, field) when is_atom(field) do
        aggregate(type, field, [])
      end

      @impl SwissSchema
      def aggregate(type, field, opts) do
        unquote(repo).aggregate(__MODULE__, type, field, opts)
      end

      @impl SwissSchema
      def all(opts \\ []) do
        unquote(repo).all(__MODULE__, opts)
      end

      @impl SwissSchema
      def create(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert(opts)
      end

      @impl SwissSchema
      def create!(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert!(opts)
      end

      @impl SwissSchema
      def delete(%{__struct__: __MODULE__} = schema, opts \\ []) do
        unquote(repo).delete(schema, opts)
      end

      @impl SwissSchema
      def delete!(%{__struct__: __MODULE__} = schema, opts \\ []) do
        unquote(repo).delete!(schema, opts)
      end

      @impl SwissSchema
      def delete_all(opts \\ []) do
        unquote(repo).delete_all(__MODULE__, opts)
      end

      @impl SwissSchema
      def get(id, opts \\ []) do
        case unquote(repo).get(__MODULE__, id, opts) do
          %{} = schema -> {:ok, schema}
          nil -> {:error, :not_found}
        end
      end

      @impl SwissSchema
      def get!(id, opts \\ []) do
        unquote(repo).get!(__MODULE__, id, opts)
      end

      @impl SwissSchema
      def get_by(clauses, opts \\ []) do
        case unquote(repo).get_by(__MODULE__, clauses, opts) do
          %{} = schema -> {:ok, schema}
          nil -> {:error, :not_found}
        end
      end

      @impl SwissSchema
      def get_by!(clauses, opts \\ []) do
        unquote(repo).get_by!(__MODULE__, clauses, opts)
      end

      @impl SwissSchema
      def insert(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert(opts)
      end

      @impl SwissSchema
      def insert!(%{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        struct(__MODULE__)
        |> changeset.(params)
        |> unquote(repo).insert!(opts)
      end

      @impl SwissSchema
      def insert_all(entries, opts \\ []) do
        unquote(repo).insert_all(__MODULE__, entries, opts)
      end

      @impl SwissSchema
      def insert_or_update(%Ecto.Changeset{} = changeset, opts \\ []) do
        unquote(repo).insert_or_update(changeset, opts)
      end

      @impl SwissSchema
      def insert_or_update!(%Ecto.Changeset{} = changeset, opts \\ []) do
        unquote(repo).insert_or_update!(changeset, opts)
      end

      @impl SwissSchema
      def stream(opts \\ []) do
        unquote(repo).stream(__MODULE__, opts)
      end

      @impl SwissSchema
      def update(%{__struct__: __MODULE__} = schema, %{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        schema
        |> changeset.(params)
        |> unquote(repo).update(opts)
      end

      @impl SwissSchema
      def update!(%{__struct__: __MODULE__} = schema, %{} = params, opts \\ []) do
        changeset = Function.capture(__MODULE__, :changeset, 2)

        schema
        |> changeset.(params)
        |> unquote(repo).update!(opts)
      end

      @impl SwissSchema
      def update_all(updates, opts \\ []) do
        unquote(repo).update_all(__MODULE__, updates, opts)
      end
    end
  end
end
