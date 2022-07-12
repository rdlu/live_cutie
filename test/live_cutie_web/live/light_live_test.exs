defmodule LiveCutieWeb.LightLiveTest do
  use LiveCutieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "initial render", %{conn: conn} do
    {:ok, view, html} = live(conn, "/light")

    assert html =~ "Lights Control"
    assert render(view) =~ "Lights Control"
  end

  test "light controls", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/light")

    assert render(view) =~ "10%"

    assert view |> element("button#lights-up") |> render_click() =~ "20%"
    assert view |> element("button#lights-down") |> render_click() =~ "10%"
    assert view |> element("button#lights-on") |> render_click() =~ "100%"
    assert view |> element("button#lights-off") |> render_click() =~ "0%"
    refute render(view) =~ "100%"
  end

  test "aria labels are present", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/light")

    for id <- ~w(lights-up lights-down lights-on lights-off) do
      assert view |> element("button#" <> id) |> render() =~ "aria-label="
    end
  end

  test "min brightness is 0%", %{conn: conn} do
    ids = ~w(lights-down lights-off)

    for click_id <- ids, disabled_id <- ids do
      {:ok, view, _html} = live(conn, "/light")
      refute view |> element("button#" <> click_id) |> render() =~ "disabled="
      refute view |> element("button#" <> disabled_id) |> render() =~ "disabled="
      assert view |> element("button#" <> click_id) |> render_click() =~ "0%"
      assert view |> element("button#" <> click_id) |> render() =~ "disabled="
      assert view |> element("button#" <> disabled_id) |> render() =~ "disabled="
    end
  end

  test "max brightness is 100%", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/light")

    refute view |> element("button#lights-on") |> render() =~ "disabled="
    refute view |> element("button#lights-up") |> render() =~ "disabled="
    assert view |> element("button#lights-on") |> render_click() =~ "100%"
    assert view |> element("button#lights-on") |> render() =~ "disabled="
    assert view |> element("button#lights-up") |> render() =~ "disabled="
  end
end
