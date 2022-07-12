defmodule LiveCutieWeb.PokeLiveTest do
  use LiveCutieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  # Reminder: this endpoint orders by the last id first, so we need to reverse the order
  test "clicking a stream link shows its details", %{conn: conn} do
    first = create_stream("First")
    second = create_stream("Second")

    {:ok, view, _html} = live(conn, "/poke")

    assert has_element?(view, "nav#stream-list a", first.name)
    assert has_element?(view, "nav#stream-list a", second.name)
    assert has_element?(view, "#stream-title", second.name)
    assert has_element?(view, "nav#stream-list a.active", second.name)

    view
    |> element("nav#stream-list a", second.name)
    |> render_click()

    assert has_element?(view, "nav#stream-list a.active", second.name)
    assert_patched(view, "/poke/#{second.slug}")
  end

  test "selects the stream identified in the URL", %{conn: conn} do
    first = create_stream("First")
    second = create_stream("Second")

    {:ok, view, _html} = live(conn, "/poke/#{first.slug}")

    assert has_element?(view, "nav#stream-list a", second.name)
    refute has_element?(view, "nav#stream-list a.active", second.name)
    assert has_element?(view, "nav#stream-list a.active", first.name)
    assert has_element?(view, "#stream-title", first.name)
  end

  defp create_stream(name) do
    {:ok, server} =
      LiveCutie.PokeGames.create_poke_game(%{
        name: name,
        # these are irrelevant for tests:
        description: "This is a poke game",
        platform: "Game Boy",
        generation: 1,
        box_image: "/images/poke_games/yellow.jpg",
        favorite: true,
        played: :yes,
        legendary: ["Articuno", "Zapdos", "Moltres", "Mewtwo"],
        starters: ["Pikachu"],
        streaming: false
      })

    server
  end
end
