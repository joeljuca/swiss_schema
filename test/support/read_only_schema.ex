defmodule SwissSchemaTest.ReadOnlyUser do
  @moduledoc false

  use Ecto.Schema
  use SwissSchema, repo: SwissSchemaTest.ReadOnlyRepo
  import Ecto.Changeset

  schema "users" do
    field(:is_active, :boolean, default: true)
    field(:username, :string)
    field(:email, :string)
    field(:lucky_number, :integer)
  end

  def changeset(%SwissSchemaTest.ReadOnlyUser{} = user, %{} = params) do
    user
    |> cast(params, [:is_active, :username, :email, :lucky_number])
    |> validate_required([:username, :email])
  end
end
