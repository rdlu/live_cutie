defmodule LiveCutie.Btus do
  @human_level %{
    0 => "Off",
    1 => "Low",
    2 => "Medium",
    3 => "High",
    4 => "Max"
  }
  def calculate(level) do
    if level < 3 do
      level * 4000
    else
      8000 + (level-2) * 2000
    end
  end

  def human_level(level) when is_map_key(@human_level, level) do
    @human_level[level]
  end
  def human_level(_level), do: "Unknown"
end
