defmodule SwissSchemaTest do
  use ExUnit.Case
  alias SwissSchemaTest.Book
  alias SwissSchemaTest.Repo
  alias SwissSchemaTest.Repo2
  alias SwissSchemaTest.User

  defp user_mock(opts \\ []) when is_list(opts) do
    username = Keyword.get(opts, :username, "user-#{Ecto.UUID.generate()}")
    email = Keyword.get(opts, :email, "#{username}@localhost")
    lucky_number = Keyword.get(opts, :lucky_number, Enum.random(1..1_000_000))

    %User{
      username: username,
      email: email,
      lucky_number: lucky_number
    }
  end

  defp book_mock(opts \\ []) when is_list(opts) do
    title = Keyword.get(opts, :title, "book-title-#{Ecto.UUID.generate()}")
    description = Keyword.get(opts, :description, "book-description-long-#{Ecto.UUID.generate()}")

    %Book{
      title: title,
      description: description
    }
  end

  setup_all do
    Enum.each([Repo, Repo2], fn repo ->
      Ecto.Adapters.Postgres.storage_up(repo.config())

      repo.start_link(log: false)
      Ecto.Migrator.up(repo, 1, SwissSchemaTest.CreateUsers, log: false)
    end)

    on_exit(fn ->
      Enum.each([Repo, Repo2], fn repo ->
        Ecto.Adapters.Postgres.storage_down(repo.config())
      end)
    end)
  end

  setup do: on_exit(fn -> Repo.delete_all(User) && Repo2.delete_all(User) end)

  describe "use SwissSchema" do
    test "requires a :repo opt" do
      assert_raise ArgumentError, fn ->
        defmodule SwissSchemaTest.BadSchema do
          @moduledoc false
          use Ecto.Schema
          use SwissSchema
          import Ecto.Changeset

          schema "users" do
          end

          @impl SwissSchema
          def changeset(_, _), do: cast(%__MODULE__{}, %{}, [])
        end
      end
    end

    test "accepts a :repo thru a :default_repo env" do
      Application.put_env(:swiss_schema, :default_repo, SwissSchemaTest.Repo)

      defmodule SwissSchemaTest.NoRepo do
        @moduledoc false
        use Ecto.Schema
        use SwissSchema
        import Ecto.Changeset

        schema "users" do
        end

        @impl SwissSchema
        def changeset(_, _), do: cast(%__MODULE__{}, %{}, [])
      end

      assert function_exported?(SwissSchemaTest.NoRepo, :create, 2)

      # Clean up
      Application.delete_env(:swiss_schema, :default_repo)
    end

    test "define aggregate/1" do
      assert function_exported?(SwissSchemaTest.User, :aggregate, 1)
    end

    test "define aggregate/2" do
      assert function_exported?(SwissSchemaTest.User, :aggregate, 2)
    end

    test "define aggregate/3" do
      assert function_exported?(SwissSchemaTest.User, :aggregate, 3)
    end

    test "define all/0" do
      assert function_exported?(SwissSchemaTest.User, :all, 0)
    end

    test "define all/1" do
      assert function_exported?(SwissSchemaTest.User, :all, 1)
    end

    test "define delete_all/0" do
      assert function_exported?(SwissSchemaTest.User, :delete_all, 0)
    end

    test "define delete_all/1" do
      assert function_exported?(SwissSchemaTest.User, :delete_all, 1)
    end

    test "define get/1" do
      assert function_exported?(SwissSchemaTest.User, :get, 1)
    end

    test "define get/2" do
      assert function_exported?(SwissSchemaTest.User, :get, 2)
    end

    test "define get!/1" do
      assert function_exported?(SwissSchemaTest.User, :get!, 1)
    end

    test "define get!/2" do
      assert function_exported?(SwissSchemaTest.User, :get!, 2)
    end

    test "define get_by/1" do
      assert function_exported?(SwissSchemaTest.User, :get_by, 1)
    end

    test "define get_by/2" do
      assert function_exported?(SwissSchemaTest.User, :get_by, 2)
    end

    test "define get_by!/1" do
      assert function_exported?(SwissSchemaTest.User, :get_by!, 1)
    end

    test "define get_by!/2" do
      assert function_exported?(SwissSchemaTest.User, :get_by!, 2)
    end

    test "define stream/0" do
      assert function_exported?(SwissSchemaTest.User, :stream, 0)
    end

    test "define stream/1" do
      assert function_exported?(SwissSchemaTest.User, :stream, 1)
    end

    test "define update_all/1" do
      assert function_exported?(SwissSchemaTest.User, :update_all, 1)
    end

    test "define update_all/2" do
      assert function_exported?(SwissSchemaTest.User, :update_all, 2)
    end

    test "define delete/1" do
      assert function_exported?(SwissSchemaTest.User, :delete, 1)
    end

    test "define delete/2" do
      assert function_exported?(SwissSchemaTest.User, :delete, 2)
    end

    test "define delete!/1" do
      assert function_exported?(SwissSchemaTest.User, :delete!, 1)
    end

    test "define delete!/2" do
      assert function_exported?(SwissSchemaTest.User, :delete!, 2)
    end

    test "define insert/1" do
      assert function_exported?(SwissSchemaTest.User, :insert, 1)
    end

    test "define insert/2" do
      assert function_exported?(SwissSchemaTest.User, :insert, 2)
    end

    test "define insert!/1" do
      assert function_exported?(SwissSchemaTest.User, :insert!, 1)
    end

    test "define insert!/2" do
      assert function_exported?(SwissSchemaTest.User, :insert!, 2)
    end

    test "define insert_all/1" do
      assert function_exported?(SwissSchemaTest.User, :insert_all, 1)
    end

    test "define insert_all/2" do
      assert function_exported?(SwissSchemaTest.User, :insert_all, 2)
    end

    test "define insert_or_update/1" do
      assert function_exported?(SwissSchemaTest.User, :insert_or_update, 1)
    end

    test "define insert_or_update/2" do
      assert function_exported?(SwissSchemaTest.User, :insert_or_update, 2)
    end

    test "define insert_or_update!/1" do
      assert function_exported?(SwissSchemaTest.User, :insert_or_update!, 1)
    end

    test "define insert_or_update!/2" do
      assert function_exported?(SwissSchemaTest.User, :insert_or_update!, 2)
    end

    test "define update/2" do
      assert function_exported?(SwissSchemaTest.User, :update, 2)
    end

    test "define update/3" do
      assert function_exported?(SwissSchemaTest.User, :update, 3)
    end

    test "define update!/2" do
      assert function_exported?(SwissSchemaTest.User, :update!, 2)
    end

    test "define update!/3" do
      assert function_exported?(SwissSchemaTest.User, :update!, 3)
    end
  end

  describe "aggregate/2" do
    test "accepts only :count as argument" do
      Enum.each([:avg, :max, :min, :sum], fn type ->
        assert_raise FunctionClauseError, fn -> User.aggregate(type) end
      end)

      User.aggregate(:count)
    end

    test "counts all rows in the schema table" do
      Repo.insert(user_mock())

      assert 1 == User.aggregate(:count)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      Repo2.insert(user_mock())

      assert 1 == User.aggregate(:count, repo: Repo2)
    end
  end

  describe "aggregate/3" do
    setup do: 1..5 |> Enum.each(fn i -> user_mock(lucky_number: i) |> Repo.insert() end)

    test "aggregate(:avg, :field, _) process the :field average" do
      assert Decimal.compare("3.0", User.aggregate(:avg, :lucky_number))
    end

    test "aggregate(:count, :field, _) process the :field count" do
      assert User.aggregate(:count, :lucky_number) == 5
    end

    test "aggregate(:max, :field, _) process the :field max" do
      assert User.aggregate(:max, :lucky_number) == 5
    end

    test "aggregate(:min, :field, _) process the :field min" do
      assert User.aggregate(:min, :lucky_number) == 1
    end

    test "aggregate(:sum, :field, _) process the :field sum" do
      assert User.aggregate(:sum, :lucky_number) == 15
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      1..5 |> Enum.each(fn i -> user_mock(lucky_number: i) |> Repo2.insert() end)

      [
        {:count, 5},
        {:max, 5},
        {:min, 1},
        {:sum, 15}
      ]
      |> Enum.each(fn {type, val} ->
        assert ^val = User.aggregate(type, :lucky_number, repo: Repo2)
      end)

      assert Decimal.compare("3.0", User.aggregate(:avg, :lucky_number, repo: Repo2))
    end
  end

  describe "all/1" do
    test "returns all rows in a schema table" do
      user_mock() |> Repo.insert()

      assert [%User{}] = User.all()
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      1..3 |> Enum.each(fn _ -> user_mock() |> Repo2.insert() end)

      assert [%User{}, %User{}, %User{}] = User.all(repo: Repo2)
    end
  end

  describe "create/2" do
    test "requires valid params" do
      [
        %{},
        %{username: "john"},
        %{email: "root@localhost"}
      ]
      |> Enum.each(fn params ->
        assert {:error, %Ecto.Changeset{}} = User.create(params)
      end)
    end

    test "creates a new row" do
      assert {:ok, %User{}} = user_mock() |> Map.from_struct() |> User.create()
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      {:ok, user} = user_mock() |> Map.from_struct() |> User.create(repo: Repo2)

      assert %User{} = user
      assert ^user = Repo2.get(User, user.id)
    end

    test "accepts a custom changeset function thru :changeset opt" do
      params = user_mock() |> Map.take([:username, :email])

      assert {:ok, user} = User.create(params, changeset: &User.changeset_custom/2)
      assert is_integer(user.lucky_number)
    end
  end

  describe "create!/2" do
    test "requires valid params" do
      [
        %{},
        %{username: "john"},
        %{email: "root@localhost"}
      ]
      |> Enum.each(fn params ->
        assert_raise Ecto.InvalidChangesetError, fn -> User.create!(params) end
      end)
    end

    test "creates a new row" do
      assert %User{} = user_mock() |> Map.from_struct() |> User.create!()
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user = user_mock() |> Map.from_struct() |> User.create!(repo: Repo2)

      assert %User{} = user
      assert ^user = Repo2.get!(User, user.id)
    end

    test "accepts a custom changeset function thru :changeset opt" do
      params = user_mock() |> Map.take([:username, :email])

      user = User.create!(params, changeset: &User.changeset_custom/2)

      assert %User{} = user
      assert is_integer(user.lucky_number)
    end
  end

  describe "delete/2" do
    setup do: %{user: user_mock() |> Repo.insert!()}

    test "deletes one row", %{user: user} do
      assert {:ok, %User{}} = User.delete(user)

      assert_raise Ecto.NoResultsError, fn -> Repo.get!(User, user.id) end
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user = user_mock() |> Repo2.insert!()

      assert {:ok, %User{}} = User.delete(user, repo: Repo2)
      assert_raise Ecto.NoResultsError, fn -> Repo2.get!(User, user.id) end
    end
  end

  describe "delete!/2" do
    setup do: %{user: user_mock() |> Repo.insert!()}

    test "deletes one row", %{user: user} do
      assert %User{} = User.delete!(user)

      assert_raise Ecto.NoResultsError, fn -> Repo.get!(User, user.id) end
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user = user_mock() |> Repo2.insert!()

      assert %User{} = User.delete!(user, repo: Repo2)
      assert_raise Ecto.NoResultsError, fn -> Repo2.get!(User, user.id) end
    end
  end

  describe "delete_all/1" do
    test "deletes all rows in a schema table" do
      user_mock() |> Repo.insert!()

      assert {1, _} = User.delete_all()
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user_mock() |> Repo2.insert!()

      assert {1, _} = User.delete_all(repo: Repo2)
    end
  end

  describe "exists?/1" do
    # See: FAQ.md

    test "is not implemented" do
      refute User.__info__(:functions) |> Keyword.get(:exists?)
    end
  end

  describe "get/2" do
    test "returns {:error, :not_found} when row is absent" do
      assert {:error, :not_found} = User.get(1)
    end

    test "returns a row by ID" do
      %User{id: id} = user_mock() |> Repo.insert!()

      assert {:ok, %User{id: ^id}} = User.get(id)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      %User{id: uid} = user_mock() |> Repo2.insert!()

      assert {:ok, %User{id: ^uid}} = User.get(uid, repo: Repo2)
    end
  end

  describe "get!/2" do
    test "throws Ecto.NoResultsError when row is absent" do
      assert_raise Ecto.NoResultsError, fn -> User.get!(1) end
    end

    test "returns a row by ID" do
      %User{id: id} = user_mock() |> Repo.insert!()

      assert %User{id: ^id} = User.get!(id)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      %User{id: uid} = user_mock() |> Repo2.insert!()

      assert %User{id: ^uid} = User.get!(uid, repo: Repo2)
    end
  end

  describe "get_by/2" do
    test "returns {:error, :not_found} when row is absent" do
      assert {:error, :not_found} = User.get_by(username: "root")
    end

    test "returns {:error, %Ecto.MultipleResultsError{}} when query returns multiple rows" do
      user_mock(username: "john", lucky_number: 7) |> Repo.insert!()
      user_mock(username: "jane", lucky_number: 7) |> Repo.insert!()

      assert {:error, %Ecto.MultipleResultsError{}} = User.get_by(lucky_number: 7)
    end

    test "returns a row by ID" do
      user_mock(username: "root") |> Repo.insert!()

      assert {:ok, %User{username: "root"}} = User.get_by(username: "root")
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      %User{username: u} = user_mock() |> Repo2.insert!()

      assert {:ok, %User{username: ^u}} = User.get_by([username: u], repo: Repo2)
    end
  end

  describe "get_by!/2" do
    test "throws Ecto.NoResultsError when row is absent" do
      assert_raise Ecto.NoResultsError, fn -> User.get_by!(username: "root") end
    end

    test "returns a row matching a set of clauses" do
      user_mock(username: "root") |> Repo.insert!()

      assert %User{username: "root"} = User.get_by!(username: "root")
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      %User{username: username} = user_mock() |> Repo2.insert!()

      assert %User{username: ^username} = User.get_by!([username: username], repo: Repo2)
    end
  end

  describe "insert/2" do
    test "inserts a row" do
      user_changeset()
      |> assert_user()
    end

    test "accepts a struct" do
      user_mock()
      |> assert_user()
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user_changeset()
      |> assert_user(Repo2)
    end

    test "not accepts changeset from other schema" do
      changeset = book_changeset()

      assert {:error, :not_same_schema_module} = User.insert(changeset)
    end

    defp user_changeset() do
      user_mock() |> Ecto.Changeset.cast(%{}, [:username, :email, :lucky_number])
    end

    defp book_changeset() do
      book_mock() |> Book.changeset(%{})
    end

    defp assert_user(changeset_or_struct, repo \\ Repo) do
      assert {:ok, %User{id: uid}} = User.insert(changeset_or_struct, repo: repo)
      assert %User{} = repo.get!(User, uid)
    end
  end

  describe "insert!/2" do
    test "inserts a row" do
      user_changeset()
      |> assert_user!()
    end

    test "accepts a struct" do
      user_mock()
      |> assert_user!()
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user_changeset()
      |> assert_user!(Repo2)
    end

    test "not accepts changeset from other schema" do
      changeset = book_changeset()

      assert {:error, :not_same_schema_module} = User.insert!(changeset)
    end

    defp assert_user!(changeset_or_struct, repo \\ Repo) do
      assert %User{id: uid} = User.insert!(changeset_or_struct, repo: repo)
      assert %User{} = repo.get!(User, uid)
    end
  end

  describe "insert_all/2" do
    test "inserts multiple rows at once" do
      params_list =
        1..10
        |> Enum.map(fn _ -> user_mock() |> Map.from_struct() end)
        |> Enum.map(&Map.take(&1, [:username, :email, :lucky_number]))

      assert {10, _} = User.insert_all(params_list)

      Enum.each(Repo.all(User), fn user ->
        assert Enum.any?(params_list, fn params -> user.email == params.email end)
      end)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      params_list =
        [
          user_mock() |> Map.from_struct(),
          user_mock() |> Map.from_struct(),
          user_mock() |> Map.from_struct()
        ]
        |> Enum.map(&Map.drop(&1, [:__meta__, :id]))

      assert {3, _} = User.insert_all(params_list, repo: Repo2)

      Enum.each(params_list, fn %{username: username} ->
        assert %User{} = User.get_by!([username: username], repo: Repo2)
      end)
    end
  end

  describe "update_all/2" do
    setup do: Enum.each(1..5, fn i -> user_mock(lucky_number: i) |> Repo.insert!() end)

    test "set multiple columns at once" do
      assert {5, _} = User.update_all(set: [lucky_number: 5])

      User.all() |> Enum.each(fn user -> assert 5 == user.lucky_number end)
    end

    test "increment multiple columns at once" do
      assert {5, _} = User.update_all(inc: [lucky_number: 3])

      assert [4, 5, 6, 7, 8] = User.all() |> Enum.map(& &1.lucky_number) |> Enum.sort()
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      1..3
      |> Enum.map(fn _ -> user_mock() |> Map.from_struct() |> Map.drop([:__meta__, :id]) end)
      |> then(&Repo2.insert_all(User, &1))

      assert {3, _} = User.update_all([set: [is_active: false]], repo: Repo2)

      Repo2.all(User)
      |> Enum.each(fn user -> assert false == user.is_active end)
    end
  end
end
