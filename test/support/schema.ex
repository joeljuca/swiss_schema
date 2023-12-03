defmodule SwissSchemaTest.User do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field(:is_active, :boolean, default: true)
    field(:username, :string)
    field(:email, :string)
    field(:lucky_number, :integer)
  end

  use SwissSchema, repo: SwissSchemaTest.Repo

  @impl true
  def changeset(%SwissSchemaTest.User{} = user, %{} = params) do
    user
    |> cast(params, [:is_active, :username, :email, :lucky_number])
    |> validate_required([:username, :email])
  end

  def custom_changeset(%SwissSchemaTest.User{} = user, %{} = params) do
    user
    |> cast(params, [:username])
    |> put_change(:email, "user-#{Ecto.UUID.generate()}@example.com")
    |> put_change(:lucky_number, System.unique_integer())
    |> validate_required([:username, :email, :lucky_number])
  end
end
