defmodule Igdb.Games do
  @moduledoc """
  Basic methods for retrieving games data from the IGDB API V3. https://www.igdb.com/
  """

  @doc """
  Gets a list of games.

  ## Examples

      iex> games = Igdb.Games.get(%{"sort" => "asc", "sort_by" => "created_at", "limit" => 5}, ["id", "name", "created_at"])
      iex> Enum.member?(games, %{"created_at" => 1297555200, "id" => 3, "name" => "Thief: Deadly Shadows"})
      true

  """
  def get(params \\ %{}, fields \\ "all"),
    do: Igdb.get_data(:games, params, fields)


  @doc """
  Search videogames using a string

  ## Examples

      iex> Igdb.Games.search("Assassins Creed", %{"limit" => 2}, ["id", "name"])
      [
        %{
          "id" => 127,
          "name" => "Assassin's Creed II"
        },
        %{
          "id" => 1266,
          "name" => "Assassin's Creed III"
        }
      ]

  """
  def search(search, params \\ %{}, fields \\ "all"),
    do: Igdb.get_data(:games, Map.merge(%{"search" => search}, params), fields)

end
