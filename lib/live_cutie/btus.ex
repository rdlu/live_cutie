defmodule LiveCutie.Btus do
  @human_level %{
    0 => "Off",
    1 => "Low",
    2 => "Medium",
    3 => "High",
    4 => "Max"
  }

  def calculate(level) do
    expiration_time = autoshutdown_timer(level)
    remaining = time_remaining(expiration_time)
    btus = calculate_btus(level)

    %{level: level,
     btus: btus,
     time_remaining: remaining,
     expiration_time: expiration_time}
  end

  def time_remaining(expiration_time) do
    DateTime.diff(expiration_time, Timex.now())
  end

  def human_level(level) when is_map_key(@human_level, level) do
    @human_level[level]
  end

  def human_level(_level), do: "Unknown"

  defp calculate_btus(level) do
    if level < 3 do
      level * 4000
    else
      8000 + (level - 2) * 2000
    end
  end

  defp autoshutdown_timer(level) do
    if level < 3 do
      Timex.shift(Timex.now(), hours: 4)
    else
      Timex.shift(Timex.now(), hours: 2)
    end
  end
end
