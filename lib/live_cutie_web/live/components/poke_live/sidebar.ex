defmodule LiveCutieWeb.Components.PokeLive.Sidebar do
  use LiveCutieWeb, :live_component

  defp link_body(game) do
    img = if game.streaming, do: "play", else: "stop"

    assigns = %{name: game.name, img: img}

    ~H"""
    <img src={"/images/#{@img}-circle.svg"} class="mr-2 h-6 w-6" />
    <%= @name %>
    """
  end
end
