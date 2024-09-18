defmodule SwissSchemaTest do
  use ExUnit.Case
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

    test "define update/1" do
      assert function_exported?(SwissSchemaTest.User, :update, 1)
    end

    test "define update/2" do
      assert function_exported?(SwissSchemaTest.User, :update, 2)
    end

    test "define update!/1" do
      assert function_exported?(SwissSchemaTest.User, :update!, 1)
    end

    test "define update!/2" do
      assert function_exported?(SwissSchemaTest.User, :update!, 2)
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

      assert {:ok, 1} == User.aggregate(:count)
    end

    test "rescues from exceptions to return an :error tuple" do
      Repo.insert(user_mock())

      Repo.transaction(fn ->
        Ecto.Adapters.SQL.query(Repo, "ALTER TABLE users RENAME TO u")

        assert {:error, _} = User.aggregate(:count)
      end)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      Repo2.insert(user_mock())

      assert {:ok, 1} == User.aggregate(:count, repo: Repo2)
    end
  end

  describe "aggregate/3" do
    setup do: Enum.each(1..5, &(user_mock(lucky_number: &1) |> Repo.insert()))

    test "aggregate(:avg, :field, _) process the :field average" do
      assert {:ok, avg} = User.aggregate(:avg, :lucky_number)
      assert Decimal.compare("3.0", avg)

      Repo.transaction(fn ->
        Repo.delete_all(User)

        assert {:ok, nil} = User.aggregate(:avg, :lucky_number)
        Repo.rollback(nil)
      end)
    end

    test "aggregate(:count, :field, _) process the :field count" do
      assert {:ok, 5} = User.aggregate(:count, :lucky_number)
    end

    test "aggregate(:min, :field, _) process the :field min" do
      assert {:ok, 1} = User.aggregate(:min, :lucky_number)
    end

    test "aggregate(:max, :field, _) process the :field max" do
      assert {:ok, 5} = User.aggregate(:max, :lucky_number)
    end

    test "aggregate(:sum, :field, _) process the :field sum" do
      assert {:ok, 15} = User.aggregate(:sum, :lucky_number)
    end

    test "rescues from exceptions to return an :error tuple" do
      for type <- [:count, :min, :max, :sum] do
        Repo.transaction(fn ->
          Ecto.Adapters.SQL.query(Repo, "ALTER TABLE users RENAME TO u")

          assert {:error, _} = User.aggregate(type, :lucky_number)
        end)
      end
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      Enum.each(1..5, &(user_mock(lucky_number: &1) |> Repo2.insert!()))

      assert {:ok, avg} = User.aggregate(:avg, :lucky_number, repo: Repo2)
      assert Decimal.compare("3.0", avg)

      [count: 5, min: 1, max: 5, sum: 15]
      |> Enum.each(fn {type, val} ->
        assert {:ok, ^val} = User.aggregate(type, :lucky_number, repo: Repo2)
      end)
    end
  end

  describe "all/1" do
    setup do
      for _ <- 1..3, do: user_mock() |> Repo.insert!()
      :ok
    end

    test "returns all rows in the schema table" do
      assert {:ok, [%User{} | _]} = User.all()
    end

    test "rescues from exceptions to return an :error tuple" do
      Repo.transaction(fn ->
        Ecto.Adapters.SQL.query(Repo, "ALTER TABLE users RENAME TO u")

        assert {:error, _} = User.all()
      end)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      for _ <- 1..3, do: user_mock() |> Repo2.insert!()

      assert {:ok, [%User{}, %User{}, %User{}]} = User.all(repo: Repo2)
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
    test "requires an Ecto schema or changeset" do
      user = user_mock()
      map = user |> Map.from_struct()

      assert_raise FunctionClauseError, fn -> User.insert(map) end
      assert {:ok, %User{}} = User.insert(user)

      changeset = Ecto.Changeset.cast(user, %{}, User.__schema__(:fields))

      assert {:ok, %User{}} = User.insert(changeset)
    end

    test "rejects invalid Ecto changesets" do
      user = user_mock()
      changeset = Ecto.Changeset.cast(user, %{lucky_number: "invalid"}, User.__schema__(:fields))

      assert {:error, %Ecto.Changeset{}} = User.insert(changeset)
    end

    test "inserts a row" do
      user = user_mock()

      assert {:ok, %User{} = user} = User.insert(user)
      assert ^user = Repo.get!(User, user.id)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      params = user_mock()

      assert {:ok, %User{id: uid}} = User.insert(params, repo: Repo2)
      assert %User{} = Repo2.get!(User, uid)
    end
  end

  describe "insert!/2" do
    test "requires an Ecto schema or changeset" do
      user = user_mock()
      map = user |> Map.from_struct()

      assert_raise FunctionClauseError, fn -> User.insert(map) end
      assert %User{} = User.insert!(user)

      changeset = Ecto.Changeset.cast(user, %{}, User.__schema__(:fields))
      assert %User{} = User.insert!(changeset)
    end

    test "rejects invalid Ecto changesets" do
      user = user_mock()
      changeset = Ecto.Changeset.cast(user, %{lucky_number: "invalid"}, User.__schema__(:fields))

      assert {:error, %Ecto.Changeset{}} = User.insert(changeset)
    end

    test "inserts a row" do
      user = user_mock()

      assert %User{} = user = User.insert!(user)
      assert ^user = Repo.get!(User, user.id)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      params = user_mock()

      assert %User{id: uid} = User.insert!(params, repo: Repo2)
      assert %User{} = Repo2.get!(User, uid)
    end
  end

  describe "update/2" do
    test "requires an Ecto changeset" do
      user = user_mock() |> Repo.insert!()
      map = user |> Map.from_struct()

      for map <- [user, map], do: assert_raise(FunctionClauseError, fn -> User.update(map) end)

      changeset = Ecto.Changeset.cast(user, %{}, User.__schema__(:fields))
      assert {:ok, %User{}} = User.update(changeset)
    end

    test "rejects invalid Ecto changesets" do
      user = user_mock() |> Repo.insert!()
      changeset = Ecto.Changeset.cast(user, %{lucky_number: "invalid"}, User.__schema__(:fields))

      assert {:error, %Ecto.Changeset{}} = User.update(changeset)
    end

    test "inserts a row" do
      user = user_mock() |> Repo.insert!()
      changeset = Ecto.Changeset.cast(user, %{lucky_number: 123}, User.__schema__(:fields))

      assert {:ok, %User{}} = User.update(changeset)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user = user_mock() |> Repo2.insert!()
      uid = user.id
      ln = Enum.random(1_000..9_999)
      changeset = Ecto.Changeset.cast(user, %{lucky_number: ln}, [:lucky_number])

      assert {:ok, %User{id: ^uid, lucky_number: ^ln}} = User.update(changeset, repo: Repo2)
    end
  end

  describe "update!/2" do
    test "requires an Ecto changeset" do
      user = user_mock() |> Repo.insert!()
      map = user |> Map.from_struct()

      for map <- [user, map], do: assert_raise(FunctionClauseError, fn -> User.update!(map) end)

      changeset = Ecto.Changeset.cast(user, %{}, User.__schema__(:fields))
      assert %User{} = User.update!(changeset)
    end

    test "rejects invalid Ecto changesets" do
      user = user_mock() |> Repo.insert!()
      changeset = Ecto.Changeset.cast(user, %{lucky_number: "invalid"}, User.__schema__(:fields))

      assert_raise Ecto.InvalidChangesetError, fn ->
        User.update!(changeset)
      end
    end

    test "updates a row" do
      user = user_mock() |> Repo.insert!()
      changeset = Ecto.Changeset.cast(user, %{lucky_number: 123}, User.__schema__(:fields))

      assert %User{lucky_number: 123} = User.update!(changeset)
    end

    test "accepts a custom Ecto repo thru :repo opt" do
      user = user_mock() |> Repo2.insert!()
      uid = user.id
      ln = Enum.random(1_000..9_999)

      changeset = Ecto.Changeset.cast(user, %{lucky_number: ln}, [:lucky_number])
      assert %User{id: ^uid, lucky_number: ^ln} = User.update!(changeset, repo: Repo2)
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

      Repo.all(User) |> Enum.each(fn user -> assert 5 == user.lucky_number end)
    end

    test "increment multiple columns at once" do
      assert {5, _} = User.update_all(inc: [lucky_number: 3])

      assert [4, 5, 6, 7, 8] = Repo.all(User) |> Enum.map(& &1.lucky_number) |> Enum.sort()
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
