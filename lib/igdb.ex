defmodule Igdb do
  @moduledoc """
  Basic methods for retrieving data from the IGDB API V3. https://www.igdb.com/
  """

  import Igdb.Query

  @url_root "https://api-v3.igdb.com/"

  # Prepares the headers that will be sent to the API. It adds the api-key required by IGDB, getting it from the environment variables.
  defp get_headers,
    do: ["user-key": Application.get_env(:igdb, :key)]


  @doc """
  Makes a request to an IGDB endpoint, being able to select the fields to retrieve, pagination, etc.

  ## Examples

      iex> Igdb.get_data(:games, %{"id" => 90512}, ["id", "name", "slug"])
      [
        %{
          "id" => 90512,
          "name" => "Asian Riddles 4",
          "slug" => "asian-riddles-4"
        }
      ]

      iex> Igdb.get_data(:gamesr)
      {:error, "Not found"}

  """
  @spec get_data(atom, map, bitstring | maybe_improper_list) :: map | {:error, String.t}
  def get_data(endpoint, params \\ %{}, fields \\ "all") do

    HTTPoison.request(
      :get,
      "#{@url_root}#{Atom.to_string(endpoint)}",
      prepare(params, fields),
      get_headers()
    )
    |> case do
      {:ok, result} -> get_data(endpoint, params, fields, {Map.get(result, :status_code), Map.get(result, :body)})
      {:error, error} -> %{error: error}
    end

  end

  defp get_data(_endpoint, _params, _fields, {status, body}) when status in [404],
    do: {:error, body}

  defp get_data(_endpoint, _params, _fields, {_status, body}),
    do: body |> Poison.decode!

end
