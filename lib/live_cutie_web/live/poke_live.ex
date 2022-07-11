defmodule LiveCutieWeb.PokeLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.PokeGames
  alias LiveCutieWeb.Components.PokeLive

  def mount(_params, _session, socket) do
    if connected?(socket), do: PokeGames.subscribe()
    games = PokeGames.list_poke_games()

    socket = assign(socket, games: games)

    {:ok, socket}
  end

  def handle_params(%{"slug" => slug}, _url, socket) do
    game = PokeGames.get_by_slug(slug)

    assign_collection(socket, game, "What's up #{game.name}?", PokeLive.MainCard, "main-card")
  end

  def handle_params(_params, _url, socket) do
    case socket.assigns.live_action do
      :new ->
        assign_collection(socket, nil, "New stream?", PokeLive.NewGame, "new-game-form")

      _ ->
        assign_collection(
          socket,
          hd(socket.assigns.games),
          "Poke Live",
          PokeLive.MainCard,
          "main-card"
        )
    end
  end

  defp assign_collection(socket, collection, page_title, main_module, main_id) do
    socket =
      assign(socket,
        selected_game: collection,
        page_title: page_title,
        main_module: main_module,
        main_id: main_id
      )

    {:noreply, socket}
  end

  def handle_info({:stream_added, game}, socket) do
    socket =
      update(
        socket,
        :games,
        fn games -> [game | games] end
      )

    {:noreply, socket}
  end

  def handle_info({:stream_updated, game}, socket) do
    socket =
      if game.id == socket.assigns.selected_game.id do
        assign(socket, selected_game: game)
      else
        socket
      end

    socket = update_loaded_list(socket, :games, game)

    {:noreply, socket}
  end

  # find the matching item (target) in the current list of items
  # change it, and update the in memory collection
  defp update_loaded_list(socket, map_key, target) do
    update(socket, map_key, &map_find_replace(&1, target))
  end

  defp map_find_replace(collection, target, key \\ :id) do
    for item <- collection do
      case Map.get(item, key) == Map.get(target, key) do
        true -> target
        _ -> item
      end
    end
  end
end
