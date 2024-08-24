defmodule SwissSchema do
  @moduledoc """
  `SwissSchema` is a query toolkit for Ecto schemas. It makes it easy to manipulate data using Ecto schemas by implementing relevant Ecto.Repo [Query API](https://hexdocs.pm/ecto/Ecto.Repo.html#query-api) and [Schema API](https://hexdocs.pm/ecto/Ecto.Repo.html#schema-api) functions, pre-configured to work specifically with the given Ecto schema.

  ## Setup

  Add `swiss_schema` as a dependency in `mix.exs`:

      def deps do
      [
        # ...
        {:swiss_schema, "~> 0.6"}
      ]
      end

  Then, `use SwissSchema` in your Ecto schemas:

      # lib/my_app/accounts/user.ex

      defmodule MyApp.Accounts.User do
        use Ecto.Schema
        use SwissSchema, repo: MyApp.Repo

        def changeset(%__MODULE__{} = user, params) do
          # Set up your schema's default changeset here
        end
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
  > To keep examples simple and short, we use the example module above, `MyApp.Accounts.User`, through the documentation. So, when reading the docs for SwissSchema functions, assume the following alias was previously set up:
  >
  >     alias MyApp.Accounts.User
  >
  > So, `MyApp.Accounts.User` will be referred to as `User`.
  """

  @doc """
  Defines the default changeset function.

  This callback is used by database-touching functions to validate changes.

  ## Examples

      User.changeset(%User{}, %{name: "John"})
      iex> %Ecto.Changeset{valid?: true}

  > See Ecto's [`Ecto.Changeset`](https://hexdocs.pm/ecto/Ecto.Changeset.html) for extensive info.
  """
  @doc group: "SwissSchema API"
  @callback changeset(
              struct :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()}
            ) :: Ecto.Changeset.t()

  @doc """
  Calculate the given aggregation.

  ## Examples

      # Returns the number of users
      User.aggregate(:count)

      # Set a timeout of 60s
      User.aggregate(:count, timeout: 60_000)

  > See Ecto's [`aggregate/3`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:aggregate/3) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
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

  > See Ecto's [`aggregate/4`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:aggregate/4) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback aggregate(
              type :: :avg | :count | :max | :min | :sum,
              field :: atom(),
              opts :: Keyword.t()
            ) :: term() | nil

  @doc """
  Fetches all entries from the respective data store.

  ## Examples

      # Fetch all users
      User.all()

  > See Ecto's [`all/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:all/2) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback all(opts :: Keyword.t()) :: [Ecto.Schema.t() | term()]

  @doc """
  Creates a new struct.

  `c:create/2` accepts a key-value map, validates it against the schema's `changeset/2`, and inserts into the repository if the validation succeeds.

  ## Examples

      # Returns an :ok tuple with valid params
      {:ok, user} = User.create(%{name: "John S.", email: "john@smiths.net"})

      # Returns an :error tuple with invalid params
      {:error, %Ecto.Changeset{...}} = User.create(%{name: 123, email: "john"})

  """
  @doc group: "SwissSchema API"
  @callback create(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Same as `c:create/2` but returns the struct or raises if parameters are invalid.
  """
  @doc group: "SwissSchema API"
  @callback create!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @doc """
  Deletes an entry using its primary key.

  It returns `{:ok, struct}` if the entry has been successfully deleted or `{:error, changeset}` if there was a validation or a known constraint error.

  ## Examples

      user = User.get!(42)

      case User.delete user do
        {:ok, user}         -> # Deleted with success
        {:error, changeset} -> # Something went wrong
      end

  > See Ecto's [`delete/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:delete/2) for extensive info.
  """
  @doc group: "Ecto.Repo Schema API"
  @callback delete(
              struct :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Same as `c:delete/2` but returns the entry, or raises.

  ## Examples

      user = User.get!(42)

      User.delete user do
        {:ok, user}         -> # Deleted with success
        {:error, changeset} -> # Something went wrong
      end

  > See Ecto's [`delete!/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:delete!/2) for extensive info.
  """
  @doc group: "Ecto.Repo Schema API"
  @callback delete!(
              struct :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @doc """
  Deletes all entries.

  It returns a two-values tuple: the number of entries deleted, and `nil`.

  ## Examples

      User.delete_all()

  > See Ecto's [`delete_all/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:delete_all/2) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback delete_all(opts :: Keyword.t()) :: {non_neg_integer(), nil | [term()]}

  @doc """
  Fetches an entry by the primary key.

  It returns `{:ok, entry}` if the entry is found, or `{:error, :not_found}` otherwise.

  ## Examples

      iex> User.get(1)
      {:ok, %User{}}

      iex> User.get(1234567890)
      {:error, :not_found}

  > See Ecto's [`get/3`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:get/3) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback get(
              id :: term(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}

  @doc """
  Similar to `c:get/2` but raises `Ecto.NoResultsError` if no entry was found.

  ## Examples

      iex> User.get!(1)
      %User{}

      iex> User.get!(1234567890)
      ** (Ecto.NoResultsError) expected at least one result but got none in query

  > See Ecto's [`get!/3`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:get!/3) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback get!(
              id :: term(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()

  @doc """
  Fetches a single entry by using a keyword list of clauses.

  It returns a single matching entry as `{:ok, entry}`, or `{:error, :not_found}` when none is found.

  ## Examples

      iex> User.get_by(email: "john@smiths.net")
      %User{}

  > See Ecto's [`get_by/3`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:get_by/3) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback get_by(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}

  @doc """
  Similar to `c:get_by/2` but raises `Ecto.NoResultsError` if no entry is found, or `Ecto.MultipleResultsError` if multiple entries are found.

  ## Examples

      iex> User.get_by!(email: "john@smiths.net")
      %User{}

      iex> User.get_by!(email: "nobody@localhost")
      ** (Ecto.NoResultsError)

      iex> User.get_by!(first_name: "John")
      ** (Ecto.MultipleResultsError)

  > See Ecto's [`get_by!/3`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:get_by!/3) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback get_by!(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()

  @doc """
  Inserts a new entry.

  Accepts a map with key-values matching respective schema fields.

  It returns `{:ok, struct}` if the entry has been successfully inserted, or
  `{:error, %Ecto.Changeset{}}` if there is a validation or a known constraint error.

  ## Examples

  A typical example is calling `c:insert/2` with a map and acting on the
  return value:

      case User.insert(%{name: "John S.", email: "john@smiths.net"}) do
        {:ok, user}         -> # Inserted with success
        {:error, changeset} -> # Something went wrong
      end

  > See Ecto's [`insert/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:insert/2) for extensive info.
  """
  @doc group: "Ecto.Repo Schema API"
  @callback insert(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Same as `c:insert/2` but returns the struct or raises if the changeset is invalid.
  """
  @doc group: "Ecto.Repo Schema API"
  @callback insert!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @doc """
  Inserts all entries into the repository.

  ## Examples

      User.insert_all([ [name: "John S."], [name: "Jane S."] ])

      User.insert_all([ %{name: "John S."}, %{name: "Jane S."} ])

  > See Ecto's [`insert_all/3`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:insert_all/3) for extensive info.
  """
  @doc group: "Ecto.Repo Schema API"
  @callback insert_all(
              entries :: [%{required(atom()) => term()}] | Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}

  @doc """
  Inserts or updates a changeset depending on whether the struct is persisted or not.

  ## Examples

      iex> User.changeset(%User{}, %{name: "John S.", email: "john@smiths.net"})
           |> User.insert_or_update()
      {:ok, %User{}}

      User.get_by!(email: "john@smiths.net")
      |> User.changeset(%{email: "john.s@smiths.net"})
      |> User.insert_or_update()

  > See Ecto's [`insert_or_update/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:insert_or_update/2) for extensive info.
  """
  @doc group: "Ecto.Repo Schema API"
  @callback insert_or_update(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Same as `c:insert_or_update/2` but returns the struct or raises if parameters are invalid.

  > See Ecto's [`insert_or_update!/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:insert_or_update!/2) for extensive info.
  """
  @doc group: "Ecto.Repo Schema API"
  @callback insert_or_update!(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @doc """
  Returns a lazy enumerable that emits all entries from the data store.

  > See Ecto's [`stream/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:stream/2) for extensive info.
  """
  @doc deprecated: "Use Ecto.Repo's stream/2 instead"
  @doc group: "Ecto.Repo Query API"
  @callback stream(opts :: Keyword.t()) :: Enum.t()

  @doc """
  Updates a struct.

  ## Examples

      iex> User.get_by!(email: "john@smiths.net")
           |> User.update(%{email: "john.s@smiths.net"})
      {:ok, %User{}}

  > See Ecto's [`update/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:update/2) for extensive info.
  """
  @doc group: "SwissSchema API"
  @callback update(
              struct :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @doc """
  Same as `c:update/3` but returns the struct or raises if parameters are invalid.

  ## Examples

      iex> User.get_by!(email: "john@smiths.net")
           |> User.update!(%{email: "john.s@smiths.net"})
      %User{}

  > See Ecto's [`update!/2`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:update!/2) for extensive info.
  """
  @doc group: "SwissSchema API"
  @callback update!(
              struct :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @doc """
  Updates all entries matching the given query with the given values.

  ## Examples

      iex> User.update_all(set: [is_active: false])

      iex> User.update_all(inc: [age: 1])

  > See Ecto's [`update_all/3`](https://hexdocs.pm/ecto/Ecto.Repo.html#c:update_all/3) for extensive info.
  """
  @doc group: "Ecto.Repo Query API"
  @callback update_all(
              updates :: Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}

  defmacro __using__(opts) do
    repo =
      case Keyword.fetch(opts, :repo) do
        {:ok, repo} -> repo
        _ -> Application.fetch_env!(:swiss_schema, :default_repo)
      end

    quote do
      @behaviour SwissSchema

      @_swiss_schema %{
        default_changeset: Function.capture(__MODULE__, :changeset, 2)
      }

      @impl SwissSchema
      def aggregate(type, opts \\ [])

      def aggregate(:count, opts) when is_list(opts) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        aggregate = Function.capture(repo, :aggregate, 3)

        aggregate.(__MODULE__, :count, opts)
      end

      def aggregate(type, field) when is_atom(field) do
        aggregate(type, field, [])
      end

      @impl SwissSchema
      def aggregate(type, field, opts) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        aggregate = Function.capture(repo, :aggregate, 4)

        aggregate.(__MODULE__, type, field, opts)
      end

      @impl SwissSchema
      def all(opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        all = Function.capture(repo, :all, 2)

        all.(__MODULE__, opts)
      end

      @impl SwissSchema
      def create(%{} = params, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        insert = Function.capture(repo, :insert, 2)
        changeset = Keyword.get(opts, :changeset, @_swiss_schema.default_changeset)

        struct(__MODULE__)
        |> changeset.(params)
        |> insert.(opts)
      end

      @impl SwissSchema
      def create!(%{} = params, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        insert! = Function.capture(repo, :insert!, 2)
        changeset = Keyword.get(opts, :changeset, @_swiss_schema.default_changeset)

        struct(__MODULE__)
        |> changeset.(params)
        |> insert!.(opts)
      end

      @impl SwissSchema
      def delete(%{__struct__: __MODULE__} = struct, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        delete = Function.capture(repo, :delete, 2)

        delete.(struct, opts)
      end

      @impl SwissSchema
      def delete!(%{__struct__: __MODULE__} = struct, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        delete! = Function.capture(repo, :delete!, 2)

        delete!.(struct, opts)
      end

      @impl SwissSchema
      def delete_all(opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        delete_all = Function.capture(repo, :delete_all, 2)

        delete_all.(__MODULE__, opts)
      end

      @impl SwissSchema
      def get(id, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        get = Function.capture(repo, :get, 3)

        case get.(__MODULE__, id, opts) do
          %{} = struct -> {:ok, struct}
          nil -> {:error, :not_found}
        end
      end

      @impl SwissSchema
      def get!(id, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        get! = Function.capture(repo, :get!, 3)

        get!.(__MODULE__, id, opts)
      end

      @impl SwissSchema
      def get_by(clauses, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        get_by = Function.capture(repo, :get_by, 3)

        case get_by.(__MODULE__, clauses, opts) do
          %{} = struct -> {:ok, struct}
          nil -> {:error, :not_found}
        end
      rescue
        error -> {:error, error}
      end

      @impl SwissSchema
      def get_by!(clauses, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        get_by! = Function.capture(repo, :get_by!, 3)

        get_by!.(__MODULE__, clauses, opts)
      end

      def insert(struct_or_changeset, opts \\ [])

      @impl SwissSchema
      def insert(%Ecto.Changeset{data: %module{}} = changeset, opts) do
        case module do
          __MODULE__ -> perform_insert(changeset, opts)
          _ -> {:error, :not_same_schema_module}
        end
      end

      @impl SwissSchema
      def insert(%module{} = struct, opts) when is_struct(struct) do
        case module do
          __MODULE__ -> perform_insert(struct, opts)
          _ -> {:error, :not_same_schema_module}
        end
      end

      defp perform_insert(source, opts) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        insert = Function.capture(repo, :insert, 2)
        insert.(source, opts)
      end

      def insert!(struct_or_changeset, opts \\ [])

      @impl SwissSchema
      def insert!(%Ecto.Changeset{data: %module{}} = changeset, opts) do
        case module do
          __MODULE__ -> perform_insert!(changeset, opts)
          _ -> {:error, :not_same_schema_module}
        end
      end

      @impl SwissSchema
      def insert!(%module{} = struct, opts) when is_struct(struct) do
        case module do
          __MODULE__ -> perform_insert!(struct, opts)
          _ -> {:error, :not_same_schema_module}
        end
      end

      defp perform_insert!(source, opts) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        insert = Function.capture(repo, :insert!, 2)
        insert.(source, opts)
      end

      @impl SwissSchema
      def insert_all(entries, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        insert_all = Function.capture(repo, :insert_all, 3)

        insert_all.(__MODULE__, entries, opts)
      end

      @impl SwissSchema
      def insert_or_update(%Ecto.Changeset{} = changeset, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        insert_or_update = Function.capture(repo, :insert_or_update, 2)

        insert_or_update.(changeset, opts)
      end

      @impl SwissSchema
      def insert_or_update!(%Ecto.Changeset{} = changeset, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        insert_or_update! = Function.capture(repo, :insert_or_update!, 2)

        insert_or_update!.(changeset, opts)
      end

      @deprecated "Use Ecto.Repo's stream/2 instead"
      @impl SwissSchema
      def stream(opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        stream = Function.capture(repo, :stream, 2)

        stream.(__MODULE__, opts)
      end

      @impl SwissSchema
      def update(%{__struct__: __MODULE__} = struct, %{} = params, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        update = Function.capture(repo, :update, 2)
        changeset = Keyword.get(opts, :changeset, @_swiss_schema.default_changeset)

        struct
        |> changeset.(params)
        |> update.(opts)
      end

      @impl SwissSchema
      def update!(%{__struct__: __MODULE__} = struct, %{} = params, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        update! = Function.capture(repo, :update!, 2)
        changeset = Keyword.get(opts, :changeset, @_swiss_schema.default_changeset)

        struct
        |> changeset.(params)
        |> update!.(opts)
      end

      @impl SwissSchema
      def update_all(updates, opts \\ []) do
        repo = Keyword.get(opts, :repo, unquote(repo))
        update_all = Function.capture(repo, :update_all, 3)

        update_all.(__MODULE__, updates, opts)
      end
    end
  end
end
