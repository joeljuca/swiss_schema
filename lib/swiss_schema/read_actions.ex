defmodule SwissSchema.ReadActions do
  
  @callback aggregate(
              type :: :count,
              opts :: Keyword.t()
            ) :: term() | nil

  @callback aggregate(
              type :: :avg | :count | :max | :min | :sum,
              field :: atom(),
              opts :: Keyword.t()
            ) :: term() | nil

  @callback all(opts :: Keyword.t()) :: [Ecto.Schema.t() | term()]

  @callback get(
              id :: term(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}

  @callback get!(
              id :: term(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()

  @callback get_by(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: {:ok, Ecto.Schema.t()} | {:ok, term()} | {:error, :not_found}

  @callback get_by!(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()

  @callback stream(opts :: Keyword.t()) :: Enum.t()
end
