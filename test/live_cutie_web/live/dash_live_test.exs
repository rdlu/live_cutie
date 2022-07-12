defmodule LiveCutieWeb.DashLiveTest do
  use LiveCutieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "refreshes when refresh button is clicked", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/dash")

    before_refresh = render(view)

    after_refresh =
      view
      |> element("button", "Refresh")
      |> render_click()

    refute after_refresh =~ before_refresh
  end

  test "refreshes automatically every tick", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/dash")

    before_refresh = render(view)

    send(view.pid, :self_refresh)

    refute render(view) =~ before_refresh
  end

  test "refreshes the temperature every tick", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/dash")

    before_refresh_sales_amount =
      view |> element("#dash-temp") |> render() |> get_text_for_selector

    send(view.pid, :self_refresh)

    after_refresh_sales_amount =
      view |> element("#dash-temp") |> render() |> get_text_for_selector

    refute before_refresh_sales_amount =~ after_refresh_sales_amount
  end

  defp get_text_for_selector(html) do
    html
    |> Floki.parse_document!()
    |> Floki.text()
  end
end
