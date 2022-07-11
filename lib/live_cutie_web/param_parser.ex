defmodule LiveCutieWeb.ParamParser do
  def param_to_integer(nil, default_value), do: default_value

  def param_to_integer(param, default_value) do
    case Integer.parse(param) do
      {number, _} ->
        number

      :error ->
        default_value
    end
  end
end
