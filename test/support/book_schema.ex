defmodule SwissSchemaTest.Book do
  @moduledoc false

  use Ecto.Schema
  use SwissSchema, repo: SwissSchemaTest.Repo
  import Ecto.Changeset

  schema "users" do
    field(:title, :string)
    field(:description, :string)
  end

  @impl SwissSchema
  def changeset(%SwissSchemaTest.Book{} = book, %{} = params) do
    book
    |> cast(params, [:title, :description])
    |> validate_required([:title])
  end
end
