defmodule SwissSchemaTest.User do
  @moduledoc false

  use Ecto.Schema
  use SwissSchema, repo: SwissSchemaTest.Repo
  import Ecto.Changeset

  schema "users" do
    field(:is_active, :boolean, default: true)
    field(:username, :string)
    field(:email, :string)
    field(:lucky_number, :integer)
  end

  @impl SwissSchema
  def changeset(%SwissSchemaTest.User{} = user, %{} = params) do
    user
    |> cast(params, [:is_active, :username, :email, :lucky_number])
    |> validate_required([:username, :email])
  end

  def changeset_custom(%SwissSchemaTest.User{} = user, %{} = params) do
    user
    |> cast(params, [:username, :email])
    |> validate_required([:username, :email])
    |> put_change(:lucky_number, Enum.random(1..1_000_000))
  end
end
