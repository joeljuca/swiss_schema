defmodule SwissSchemaTest do
  use ExUnit.Case
  doctest SwissSchema
  alias SwissSchemaTest.Repo
  alias SwissSchemaTest.User

  @database_path Application.compile_env!(:swiss_schema, :sqlite_database_path)

  setup_all do
    File.rm(@database_path)
    on_exit(fn -> File.rm(@database_path) end)

    SwissSchemaTest.Repo.start_link(database: @database_path, log: false)
    Ecto.Migrator.up(Repo, 1, SwissSchemaTest.CreateUsers, log: false)

    :ok
  end

  setup do: on_exit(fn -> Repo.delete_all(User) end)

  defp user_mock do
    username = "user-#{Ecto.UUID.generate()}"

    %User{
      username: username,
      email: username <> "@localhost",
      lucky_number: Enum.random(1..1_000_000)
    }
  end

  describe "use SwissSchema" do
    test "requires a :repo option" do
      assert_raise KeyError, fn ->
        defmodule SwissSchemaTest.BadSchema do
          use Ecto.Schema
          use SwissSchema
        end
      end
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
      assert User.aggregate(:count) == 0

      Repo.insert(%User{username: "root", email: "root@localhost", lucky_number: 1})

      assert User.aggregate(:count) == 1
    end
  end

  describe "aggregate/3" do
    setup do
      [1, 2, 3, 4, 5]
      |> Enum.each(fn number ->
        Repo.insert(%User{
          username: Ecto.UUID.generate(),
          email: "#{Ecto.UUID.generate()}@localhost",
          lucky_number: number
        })
      end)
    end

    test "aggregate(:avg, :field, _) process the :field average" do
      assert User.aggregate(:avg, :lucky_number) == 3.0
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
  end

  describe "all/1" do
    test "returns all rows in a schema table" do
      assert User.all() == []

      user_mock() |> Repo.insert()

      assert [%User{}] = User.all()
    end
  end

  describe "delete_all/1" do
    test "deletes all rows in a schema table" do
      assert {0, _} = User.delete_all()

      user_mock() |> Repo.insert()

      assert {1, _} = User.delete_all()
    end
  end

  describe "get/2" do
    test "returns {:error, :not_found} when row is absent" do
      assert {:error, :not_found} = User.get(1)
    end

    test "returns a row by ID" do
      {:ok, %{id: id}} = user_mock() |> Repo.insert()

      assert {:ok, %User{id: ^id}} = User.get(id)
    end
  end

  describe "get!/2" do
    test "throws Ecto.NoResultsError when row is absent" do
      assert_raise Ecto.NoResultsError, fn -> User.get!(1) end
    end

    test "returns a row by ID" do
      %{id: id} = user_mock() |> Repo.insert!()

      assert %User{id: ^id} = User.get!(id)
    end
  end

  describe "get_by/2" do
    test "returns {:error, :not_found} when row is absent" do
      assert {:error, :not_found} = User.get_by(username: "root")
    end

    test "returns a row by ID" do
      %User{username: "root", email: "a@b.c", lucky_number: 123} |> Repo.insert()

      assert {:ok, %User{username: "root"}} = User.get_by(username: "root")
    end
  end

  describe "get_by!/2" do
    test "throws Ecto.NoResultsError when row is absent" do
      assert_raise Ecto.NoResultsError, fn -> User.get_by!(username: "root") end
    end

    test "returns a row by ID" do
      %User{username: "root", email: "a@b.c", lucky_number: 123} |> Repo.insert()

      assert %User{username: "root"} = User.get_by!(username: "root")
    end
  end
end
