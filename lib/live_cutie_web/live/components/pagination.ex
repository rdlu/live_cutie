defmodule LiveCutieWeb.Components.Pagination do
  use LiveCutieWeb, :live_component

  defp pagination_link(socket, target, text, page, options, class) do
    live_patch(text,
      to:
        Routes.live_path(
          socket,
          target,
          Map.merge(options, %{page: page})
        ),
      class:
        "#{class} hover:bg-slate-300 -ml-px inline-flex items-center px-3 py-2 border border-slate-300 bg-white text-base leading-5 font-medium text-slate-600 no-underline"
    )
  end
end
