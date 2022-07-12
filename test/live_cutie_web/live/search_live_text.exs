defmodule LiveCutieWeb.SearchLiveTest do
  use LiveCutieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "search shows matching stores", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/search")

    view
    |> form("#zip-search", %{zip: "90001"})
    |> render_submit()

    assert has_element?(view, "li", "Loja 4")
    refute has_element?(view, "li", "Loja 1")
  end

  test "search with no results shows error", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/search")

    view
    |> form("#zip-search", %{zip: "00000"})
    |> render_submit()

    assert render(view) =~ "Nothing found for 00000"
  end
end
