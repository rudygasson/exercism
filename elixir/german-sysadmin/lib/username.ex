defmodule Username do
  def sanitize([]), do: []
  def sanitize([h | t]) do
    sanitized = case h do
      ?_ -> [h]
      ?ä -> [?a, ?e]
      ?ö -> [?o, ?e]
      ?ü -> [?u, ?e]
      ?ß -> [?s, ?s]
      h when h < ?a or h > ?z -> []
      _ -> [h]
    end
    sanitized ++ sanitize(t)
  end
end
