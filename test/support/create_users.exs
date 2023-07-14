defmodule SwissSchemaTest.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:is_active, :boolean, null: false, default: true)
      add(:username, :string, null: false)
      add(:email, :string, null: false)
      add(:lucky_number, :integer, null: false)
    end
  end
end
