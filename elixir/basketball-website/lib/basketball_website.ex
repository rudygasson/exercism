defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    if tl(keys) == [] do
      data[hd(keys)]
    else
      extract_from_path(data[hd(keys)], Enum.join(tl(keys), "."))
    end
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
