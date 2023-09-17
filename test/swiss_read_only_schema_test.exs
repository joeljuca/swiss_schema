defmodule SwissReadOnlySchemaTest do
  use ExUnit.Case
  
  describe "use SwissSchema with read-only repo" do
    test "define aggregate/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :aggregate, 1)
    end

    test "define aggregate/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :aggregate, 2)
    end

    test "define aggregate/3" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :aggregate, 3)
    end

    test "define all/0" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :all, 0)
    end

    test "define all/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :all, 1)
    end

    test "not define delete_all/0" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :delete_all, 0) === false
    end

    test "not define delete_all/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :delete_all, 1) === false
    end

    test "define get/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get, 1)
    end

    test "define get/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get, 2)
    end

    test "define get!/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get!, 1)
    end

    test "define get!/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get!, 2)
    end

    test "define get_by/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get_by, 1)
    end

    test "define get_by/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get_by, 2)
    end

    test "define get_by!/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get_by!, 1)
    end

    test "define get_by!/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :get_by!, 2)
    end

    test "define stream/0" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :stream, 0)
    end

    test "define stream/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :stream, 1)
    end

    test "not define update_all/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :update_all, 1) === false
    end

    test "not define update_all/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :update_all, 2) === false
    end

    test "not define delete/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :delete, 1) === false
    end

    test "not define delete/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :delete, 2) === false
    end

    test "not define delete!/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :delete!, 1) === false
    end

    test "not define delete!/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :delete!, 2) === false
    end

    test "not define insert/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert, 1) === false
    end

    test "not define insert/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert, 2) === false
    end

    test "not define insert!/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert!, 1) === false
    end

    test "not define insert!/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert!, 2) === false
    end

    test "not define insert_all/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert_all, 1) === false
    end

    test "not define insert_all/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert_all, 2) === false
    end

    test "not define insert_or_update/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert_or_update, 1) === false
    end

    test "not define insert_or_update/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert_or_update, 2) === false
    end

    test "not define insert_or_update!/1" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert_or_update!, 1) === false
    end

    test "not define insert_or_update!/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :insert_or_update!, 2) === false
    end

    test "not define update/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :update, 2) === false
    end

    test "not define update/3" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :update, 3) === false
    end

    test "not define update!/2" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :update!, 2) === false
    end

    test "not define update!/3" do
      assert function_exported?(SwissSchemaTest.ReadOnlyUser, :update!, 3) === false
    end
  end
end
