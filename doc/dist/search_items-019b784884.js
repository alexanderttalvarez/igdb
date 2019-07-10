searchNodes=[{"ref":"Igdb.html","title":"Igdb","type":"module","doc":"Basic methods for retrieving data from the IGDB API V3. https://www.igdb.com/"},{"ref":"Igdb.html#get_data/3","title":"Igdb.get_data/3","type":"function","doc":"Makes a request to an IGDB endpoint, being able to select the fields to retrieve, pagination, etc. Examples iex&gt; Igdb.get_data(:games, %{&quot;id&quot; =&gt; 90512}, [&quot;id&quot;, &quot;name&quot;, &quot;slug&quot;]) [ %{ &quot;id&quot; =&gt; 90512, &quot;name&quot; =&gt; &quot;Asian Riddles 4&quot;, &quot;slug&quot; =&gt; &quot;asian-riddles-4&quot; } ] iex&gt; Igdb.get_data(:gamesr) {:error, &quot;Not found&quot;}"},{"ref":"Igdb.Games.html","title":"Igdb.Games","type":"module","doc":"Basic methods for retrieving games data from the IGDB API V3. https://www.igdb.com/"},{"ref":"Igdb.Games.html#get/2","title":"Igdb.Games.get/2","type":"function","doc":"Gets a list of games. Examples iex&gt; games = Igdb.Games.get(%{&quot;sort&quot; =&gt; &quot;asc&quot;, &quot;sort_by&quot; =&gt; &quot;created_at&quot;, &quot;limit&quot; =&gt; 5}, [&quot;id&quot;, &quot;name&quot;, &quot;created_at&quot;]) iex&gt; Enum.member?(games, %{&quot;created_at&quot; =&gt; 1297555200, &quot;id&quot; =&gt; 3, &quot;name&quot; =&gt; &quot;Thief: Deadly Shadows&quot;}) true"},{"ref":"Igdb.Games.html#search/3","title":"Igdb.Games.search/3","type":"function","doc":"Search videogames using a string Examples iex&gt; Igdb.Games.search(&quot;Assassins Creed&quot;, %{&quot;limit&quot; =&gt; 2}, [&quot;id&quot;, &quot;name&quot;]) [ %{ &quot;id&quot; =&gt; 127, &quot;name&quot; =&gt; &quot;Assassin&#39;s Creed II&quot; }, %{ &quot;id&quot; =&gt; 1266, &quot;name&quot; =&gt; &quot;Assassin&#39;s Creed III&quot; } ]"},{"ref":"Igdb.Images.html","title":"Igdb.Images","type":"module","doc":"Modules to retrieve the images from the API"},{"ref":"Igdb.Images.html#download_game_images/2","title":"Igdb.Images.download_game_images/2","type":"function","doc":"Retrieves and downloads the images of a particular game using the game ID"},{"ref":"Igdb.Images.html#get_game_images/2","title":"Igdb.Images.get_game_images/2","type":"function","doc":"Retrieves the images from a single game Examples iex&gt; images = Igdb.Images.get_game_images(113113) iex&gt; images |&gt; Enum.member?(%{ ...&gt; &quot;alpha_channel&quot; =&gt; false, ...&gt; &quot;animated&quot; =&gt; false, ...&gt; &quot;game&quot; =&gt; 113113, ...&gt; &quot;height&quot; =&gt; 902, ...&gt; &quot;id&quot; =&gt; 268575, ...&gt; &quot;image_id&quot; =&gt; &quot;sc5r8f&quot;, ...&gt; &quot;url&quot; =&gt; &quot;//images.igdb.com/igdb/image/upload/t_thumb/sc5r8f.jpg&quot;, ...&gt; &quot;urls&quot; =&gt; %{ ...&gt; &quot;1080p&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_1080p/sc5r8f.jpg&quot;, ...&gt; &quot;720p&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_720p/sc5r8f.jpg&quot;, ...&gt; &quot;cover_big&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_cover_big/sc5r8f.jpg&quot;, ...&gt; &quot;cover_small&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_cover_small/sc5r8f.jpg&quot;, ...&gt; &quot;logo_med&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_logo_med/sc5r8f.jpg&quot;, ...&gt; &quot;micro&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_micro/sc5r8f.jpg&quot;, ...&gt; &quot;screenshot_big&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_screenshot_big/sc5r8f.jpg&quot;, ...&gt; &quot;screenshot_huge&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_screenshot_huge/sc5r8f.jpg&quot;, ...&gt; &quot;screenshot_med&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_screenshot_med/sc5r8f.jpg&quot;, ...&gt; &quot;thumb&quot; =&gt; &quot;http://images.igdb.com/igdb/image/upload/t_thumb/sc5r8f.jpg&quot; ...&gt; }, ...&gt; &quot;width&quot; =&gt; 1600 ...&gt; }) true"},{"ref":"Igdb.Query.html","title":"Igdb.Query","type":"module","doc":"Modules for creating the queries that will be sent to the API."},{"ref":"Igdb.Query.html#get_fields/1","title":"Igdb.Query.get_fields/1","type":"function","doc":""},{"ref":"Igdb.Query.html#get_params/1","title":"Igdb.Query.get_params/1","type":"function","doc":""},{"ref":"Igdb.Query.html#get_params/2","title":"Igdb.Query.get_params/2","type":"function","doc":""},{"ref":"Igdb.Query.html#get_params/3","title":"Igdb.Query.get_params/3","type":"function","doc":""},{"ref":"Igdb.Query.html#get_params/4","title":"Igdb.Query.get_params/4","type":"function","doc":""},{"ref":"Igdb.Query.html#prepare/2","title":"Igdb.Query.prepare/2","type":"function","doc":""},{"ref":"Igdb.Query.html#where_clause/3","title":"Igdb.Query.where_clause/3","type":"function","doc":""}]