defmodule BirdCount do
  def today([]), do: nil
  def today([h | _t]), do: h

  def increment_day_count([]), do: [1]
  def increment_day_count([h | t]), do: [h + 1 | t]

  def has_day_without_birds?(list) do
    case list do
      [] -> false
      [0 | _] -> true
      [_ | t] -> has_day_without_birds?(t)
    end
  end

  def total([]), do: 0
  def total([h | t]), do: h + total(t)

  def busy_days(list) do
    case list do
      [] -> 0
      [h | t] when h >= 5 -> busy_days(t) + 1
      [_ | t] -> busy_days(t)
    end
  end
end
