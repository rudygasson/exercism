defmodule LogLevel do
  def to_label(level, legacy?) do
    labels = {:trace, :debug, :info, :warning, :error, :fatal}
    cond do
      level > 0 && level < 5 -> elem(labels, level)
      (level == 0 || level == 5) && !legacy? -> elem(labels, level)
      true -> :unknown
    end
  end

  def alert_recipient(level, legacy?) do
    case { to_label(level, legacy?), legacy? } do
      { :error, _ } -> :ops
      { :fatal, _ } -> :ops
      { :unknown, true } -> :dev1
      { :unknown, false } -> :dev2
      { _, _ } -> false
    end
  end
end
