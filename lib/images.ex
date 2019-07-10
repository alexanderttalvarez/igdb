defmodule Igdb.Images do
  @moduledoc """
  Modules to retrieve the images from the API
  """

  @images_url "http://images.igdb.com/igdb/image/upload/t_"
  @images_sizes ["cover_small",
    "screenshot_med",
    "cover_big",
    "logo_med",
    "screenshot_big",
    "screenshot_huge",
    "thumb",
    "micro",
    "720p",
    "1080p"]


  @doc """
  Retrieves the images from a single game

  ## Examples

      iex> images = Igdb.Images.get_game_images(113113)
      iex> images |> Enum.member?(%{
      ...>    "alpha_channel" => false,
      ...>    "animated" => false,
      ...>    "game" => 113113,
      ...>    "height" => 902,
      ...>    "id" => 268575,
      ...>    "image_id" => "sc5r8f",
      ...>    "url" => "//images.igdb.com/igdb/image/upload/t_thumb/sc5r8f.jpg",
      ...>    "urls" => %{
      ...>      "1080p" => "http://images.igdb.com/igdb/image/upload/t_1080p/sc5r8f.jpg",
      ...>      "720p" => "http://images.igdb.com/igdb/image/upload/t_720p/sc5r8f.jpg",
      ...>      "cover_big" => "http://images.igdb.com/igdb/image/upload/t_cover_big/sc5r8f.jpg",
      ...>      "cover_small" => "http://images.igdb.com/igdb/image/upload/t_cover_small/sc5r8f.jpg",
      ...>      "logo_med" => "http://images.igdb.com/igdb/image/upload/t_logo_med/sc5r8f.jpg",
      ...>      "micro" => "http://images.igdb.com/igdb/image/upload/t_micro/sc5r8f.jpg",
      ...>      "screenshot_big" => "http://images.igdb.com/igdb/image/upload/t_screenshot_big/sc5r8f.jpg",
      ...>      "screenshot_huge" => "http://images.igdb.com/igdb/image/upload/t_screenshot_huge/sc5r8f.jpg",
      ...>      "screenshot_med" => "http://images.igdb.com/igdb/image/upload/t_screenshot_med/sc5r8f.jpg",
      ...>      "thumb" => "http://images.igdb.com/igdb/image/upload/t_thumb/sc5r8f.jpg"
      ...>    },
      ...>    "width" => 1600
      ...>  })
      true

  """
  @spec get_game_images(Number, list) :: {:error, String.t} | list
  def get_game_images(game_id, sizes \\ @images_sizes),
    do: get_game_images(game_id, sizes, Igdb.Games.get(%{"id" => game_id}, ["screenshots.*"]))

  defp get_game_images(_game_id, _sizes, {:error, error}),
    do: {:error, error}

  defp get_game_images(_game_id, _sizes, []),
    do: {:error, "No game found"}

  defp get_game_images(_game_id, sizes, game),
    do: get_game_images(nil, sizes, game, List.first(game) |> Map.get("screenshots"))

  defp get_game_images(_game_id, _sizes, _game, screenshots) when screenshots in ["", [""], [], nil],
    do: []

  defp get_game_images(_game_id, sizes, _game, screenshots),
    do: screenshots
      |> Enum.map(fn image ->
        [_basename, ext] = "#{image["url"] |> Path.basename}" |> String.split(".")
        image
        |> Map.put("urls",
          Enum.reduce(sizes, %{}, fn size, acc ->
            Map.put(acc, size, "#{@images_url}#{size}/#{image["image_id"]}.#{ext}")
          end)
        )
      end)


  @doc """
  Retrieves and downloads the images of a particular game using the game ID
  """
  def download_game_images(game_id, path \\ File.cwd! <> "/images"),
    do: download_game_images(game_id, path, get_game_images(game_id))

  defp download_game_images(_game_id, _path, error) when is_tuple(error),
    do: error

  defp download_game_images(_game_id, path, images) do
    # Checking if the path exists, to create it beforehand
    if !File.exists?(path) do
      File.mkdir!(path)
    end

    # Downloading every image in the path folder, using its original name
    Enum.map(images, fn image ->
      download_game_images(nil, path, nil, image)
    end)
  end

  defp download_game_images(_game_id, path, _images, image) do
    {image["image_id"],
      image["urls"]
      |> Enum.map(fn {size, url} ->
        %HTTPoison.Response{body: body, status_code: status_code} = HTTPoison.get!(url)

        download_game_images(nil, path, nil, nil, {size, url, body, status_code})
      end)}
  end

  defp download_game_images(_game_id, path, _images, _image, {size, url, body, status_code}) when status_code in [200] do
    [basename, ext] = "#{url |> Path.basename}" |> String.split(".")
    {size, File.write!("#{path}/#{basename}_#{size}.#{ext}", body)}
  end

  defp download_game_images(_game_id, _path, _images, _image, {size, _url, _body, status_code}),
    do: {size, {:error, status_code}}

end
