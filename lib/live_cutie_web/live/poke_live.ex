defmodule LiveCutieWeb.PokeLive do
  use LiveCutieWeb, :live_view

  alias LiveCutie.PokeGames

  def mount(_params, _session, socket) do
    games = PokeGames.list_poke_games()

    socket = assign(socket, games: games, selected_game: hd(games))

    {:ok, socket}
  end

  # handle params is the main entry point for handling params.
  def handle_params(%{"id" => id}, _url, socket) do
    id = String.to_integer(id)

    game = PokeGames.get_poke_game!(id)

    socket =
      assign(socket,
        selected_game: game,
        page_title: "What's up #{game.name}?"
      )

    {:noreply, socket}
  end

  def handle_params(%{"slug" => slug}, _url, socket) do
    game = PokeGames.get_by_slug(slug)

    socket =
      assign(socket,
        selected_game: game,
        page_title: "What's up #{game.name}?"
      )

    {:noreply, socket}
  end

  def handle_params(_, _url, socket) do
    {:noreply, socket}
  end

  defp link_body(game) do
    assigns = %{name: game.name}

    ~H"""
    <img src="/images/play-circle-solid.svg" class="mr-2 h-6 w-6 text-indigo-400" />
    <%= @name %>
    """
  end

  defp streaming_class(game) do
    if game.streaming do
      "bg-green-200 text-green-800"
    else
      "bg-red-200 text-red-800"
    end
  end

  defp platform_img(game) do
    "/images/hardware/#{Slug.slugify(game.platform)}.svg"
  end

  defp simple_list(list) do
    list |> Enum.join(", ")
  end
end
