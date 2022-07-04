defmodule LiveCutie.Dash do
  def lumens do
    Range.new(0, 3000, 300) |> Enum.random()
  end

  def temperature do
    Enum.random(20..30)
  end

  def co2 do
    Range.new(300, 3000, 100) |> Enum.random()
  end
end
