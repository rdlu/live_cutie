defmodule LiveCutieWeb.SliderLiveTest do
  use LiveCutieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "updating the ac controls", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/slider")

    # Default value
    assert has_element?(view, "#current-level", "Medium")
    assert has_element?(view, "#current-btu", "8000 BTU/h")

    # Updates to level 0
    view
    |> form("#update-level", %{level: 0})
    |> render_change()

    assert has_element?(view, "#current-level", "Off")
    assert has_element?(view, "#current-btu", "0 BTU/h")

    # Updates to level 1
    view
    |> form("#update-level", %{level: 1})
    |> render_change()

    assert has_element?(view, "#current-level", "Low")
    assert has_element?(view, "#current-btu", "4000 BTU/h")

    # Updates to level 3
    view
    |> form("#update-level", %{level: 3})
    |> render_change()

    assert has_element?(view, "#current-level", "High")
    assert has_element?(view, "#current-btu", "10000 BTU/h")

    # Updates to level 4
    view
    |> form("#update-level", %{level: 4})
    |> render_change()

    assert has_element?(view, "#current-level", "Max")
    assert has_element?(view, "#current-btu", "12000 BTU/h")
  end
end
