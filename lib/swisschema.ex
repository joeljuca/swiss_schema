defmodule Swisschema do
  @moduledoc """
  Documentation for `Swisschema`.
  """

  defmacro __using__(opts) do
    repo = Keyword.fetch!(opts, :repo)

    quote do
      @spec aggregate(
              aggregate :: :count,
              opts :: Keyword.t()
            ) :: term() | nil
      def aggregate(:count, opts \\ []), do: unquote(repo).aggregate(__MODULE__, :count, opts)

      @spec aggregate(
              type :: :avg | :count | :max | :min | :sum,
              field :: atom(),
              opts :: Keyword.t()
            ) :: term() | nil
      def aggregate(type, field, opts \\ []), do: unquote(repo).aggregate(type, field, opts)

      @spec all(opts :: Keyword.t()) :: [Ecto.Schema.t() | term()]
      def all(opts \\ []), do: unquote(repo).all(__MODULE__, opts)

      @spec delete_all(opts :: Keyword.t()) :: {non_neg_integer(), nil | [term()]}
      def delete_all(opts \\ []), do: unquote(repo).delete_all(__MODULE__, opts)

      @spec get(
              id :: term(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term() | nil
      def get(id, opts \\ []), do: unquote(repo).get(__MODULE__, id, opts)

      @spec get!(
              id :: term(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()
      def get!(id, opts \\ []), do: unquote(repo).get!(__MODULE__, id, opts)

      @spec get_by(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term() | nil
      def get_by(clauses, opts \\ []), do: unquote(repo).get_by(__MODULE__, clauses, opts)

      @spec get_by!(
              clauses :: Keyword.t() | map(),
              opts :: Keyword.t()
            ) :: Ecto.Schema.t() | term()
      def get_by!(clauses, opts \\ []), do: unquote(repo).get_by!(__MODULE__, clauses, opts)

      @spec stream(opts :: Keyword.t()) :: Enum.t()
      def stream(opts \\ []), do: unquote(repo).stream(__MODULE__, opts)

      @spec update_all(
              updates :: Keyword.t(),
              opts :: Keyword.t()
            ) :: {non_neg_integer(), nil | [term()]}
      def update_all(updates, opts \\ []), do: unquote(repo).update_all(__MODULE__, updates, tops)
    end
  end
end
