defmodule LiveCutieWeb.AutocompleteLiveTest do
  use LiveCutieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "typing in city field suggests a city", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/complete")

    view
    |> form("#search-by-city", %{city: "R"})
    |> render_change()

    assert has_element?(view, "#cities option", "Rio de Janeiro - RJ")
  end

  test "search by city shows matching stores", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/complete")

    view
    |> form("#search-by-city", %{city: "Rio de Janeiro - RJ"})
    |> render_submit()

    assert has_element?(view, "li", "Loja 3")
  end

  test "search by city with no results shows error", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/complete")

    view
    |> form("#search-by-city", %{city: ""})
    |> render_submit()

    assert render(view) =~ "Nothing found for"
  end
end
