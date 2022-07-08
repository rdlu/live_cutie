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

  # This "handle_params" clause needs to assign socket data
  # based on whether the action is "new" or not.
  def handle_params(_params, _url, socket) do
    if socket.assigns.live_action == :new do
      # The live_action is "new", so the form is being
      # displayed. Therefore, assign an empty changeset
      # for the form. Also don't show the selected
      # game in the sidebar which would be confusing.

      changeset = PokeGames.change_poke_game(%PokeGames.PokeGame{})

      socket =
        assign(socket,
          selected_game: nil,
          changeset: changeset
        )

      {:noreply, socket}
    else
      # The live_action is NOT "new", so the form
      # is NOT being displayed. Therefore, don't assign
      # an empty changeset. Instead, just select the
      # first game in list. This previously happened
      # in "mount", but since "handle_params" is always
      # invoked after "mount", we decided to select the
      # default game here instead of in "mount".

      socket =
        assign(socket,
          selected_game: hd(socket.assigns.games)
        )

      {:noreply, socket}
    end
  end

  def handle_event("save", %{"poke_game" => params}, socket) do
    :timer.sleep(:timer.seconds(2))

    case PokeGames.create_poke_game(params) do
      {:ok, game} ->
        # Prepend newly-minted poke_game to list.

        socket =
          update(
            socket,
            :games,
            fn games -> [game | games] end
          )

        # Navigate to the new game's detail page.
        # Invokes handle_params which already gets the
        # game and sets it as the selected game.

        socket =
          push_patch(socket,
            to:
              Routes.live_path(
                socket,
                __MODULE__,
                id: game.id
              )
          )

        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        # Assign errored changeset for form.
        socket = assign(socket, changeset: changeset)
        {:noreply, socket}
    end
  end

  def handle_event("validate", %{"poke_game" => params}, socket) do
    changeset =
      %PokeGames.PokeGame{}
      |> PokeGames.change_poke_game(params)
      |> Map.put(:action, :insert)

    socket = assign(socket, changeset: changeset)

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

  defp text_input_class do
    "focus:outline-none:border-indigo-300:ring:ring-indigo-300 w-full appearance-none px-3 py-2 border border-slate-400 rounded-md transition duration-150 ease-in-out text-base text-xl"
  end

  defp label_input_class do
    "block text-lg font-medium text-slate-600 mb-2"
  end

  defp submit_class do
    "focus:outline-none focus:border-green-700 focus:ring focus:ring-green-300 hover:bg-green-700 inline-block no-underline py-2 px-4 border border-transparent font-medium rounded-md text-white bg-green-500 transition duration-150 ease-in-out outline-none flex-initial text-lg"
  end
end
