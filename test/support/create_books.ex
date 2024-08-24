defmodule SwissSchemaTest.CreateBooks do
  @moduledoc false

  use Ecto.Migration

  def change do
    create table(:books) do
      add(:title, :string, null: false)
      add(:description, :string)
    end
  end
end
