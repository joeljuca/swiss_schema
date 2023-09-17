defmodule SwissSchema.WriteActions do

  @callback create(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback create!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback delete(
              schema :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback delete!(
              schema :: Ecto.Schema.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback delete_all(opts :: Keyword.t()) :: {non_neg_integer(), nil | [term()]}

  @callback insert(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback insert!(
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback insert_all(
              entries :: [%{required(atom()) => term()}] | Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}

  @callback insert_or_update(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback insert_or_update!(
              changeset :: Ecto.Changeset.t(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback update(
              schema :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}

  @callback update!(
              schema :: Ecto.Schema.t(),
              params :: %{required(atom()) => term()},
              opts :: Keyword.t()
            ) :: Ecto.Schema.t()

  @callback update_all(
              updates :: Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}
  
end
