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
