defmodule Igdb.Query do
  @moduledoc """
  Modules for creating the queries that will be sent to the API.
  """

  @page_size 50

  @doc """
  Prepares the query string with the parameters and fields.
  """
  @spec prepare(map, bitstring | maybe_improper_list) :: binary
  def prepare(params, fields),
    do: "#{get_fields(fields)}#{get_params(params)}"

  defp get_fields("all"),
    do: "fields *;"

  defp get_fields(fields) when is_bitstring(fields),
    do: "fields;"

  defp get_fields(fields) when is_list(fields),
    do: "fields #{fields |> Enum.join(",")};"


  @doc """
  Prepares the string for parameters such as the pagination, sorting or search
  """
  @spec get_params(map) :: binary
  def get_params(params \\ %{}) do
    get_params(:limit, params) <>
    get_params(:page, params) <>
    get_params(:sort, params) <>
    get_params(:search, params) <>
    where_clause(params)
  end

  defp get_params(:limit, params),
    do: get_params(:limit, params, Map.get(params, "limit"))

  defp get_params(:page, params),
    do: get_params(:page, params, Map.get(params, "page"))

  defp get_params(:sort, params),
    do: get_params(:sort, params, Map.get(params, "sort_by"))

  defp get_params(:search, params),
    do: get_params(:search, params, Map.get(params, "search"))


  # Preparing the limit
  defp get_params(:limit, _params, nil),
    do: "limit #{@page_size};"

  defp get_params(:limit, _params, limit),
    do: "limit #{limit};"

  # Preparing the page number
  defp get_params(:page, _params, nil),
    do: ""

  defp get_params(:page, params, page),
    do: get_params(:page, params, page, Map.get(params, "limit"))

  # Preparing the sorting
  defp get_params(:sort, _params, nil),
    do: ""

  defp get_params(:sort, params, sort_by),
    do: get_params(:sort, params, sort_by, Map.get(params, "sort"))

  # Preparing the search
  defp get_params(:search, _params, nil),
    do: ""

  defp get_params(:search, _params, search),
    do: "search \"#{search}\";"

  defp get_params(:page, _params, page, nil),
    do: "offset #{page * @page_size};"

  defp get_params(:page, _params, page, limit),
    do: "offset #{page * limit};"

  defp get_params(:sort, _params, sort_by, nil),
    do: "sort #{sort_by} desc;"

  defp get_params(:sort, _params, sort_by, sort),
    do: "sort #{sort_by} #{sort};"


  # Builds a string with the necessary query with the where clause
  defp where_clause(params) do
    wheres = []
    |> Enum.concat([where_clause(:id, params)])
    |> Enum.reject(&(&1 == ""))

    case wheres do
      [] -> ""
      w -> "where #{Enum.join(w, " & ")};"
    end
  end

  defp where_clause(:id, params),
    do: where_clause(:id, params, Map.get(params, "id"))

  # Preparing the ID
  defp where_clause(search_field, _params, nil) when is_atom(search_field),
    do: ""

  defp where_clause(:id, _params, id),
    do: "id = #{id}"

end
