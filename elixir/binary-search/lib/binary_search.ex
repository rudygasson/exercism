defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found

  def search(numbers, key) do
    search(numbers, key, 0, tuple_size(numbers) - 1)
  end

  defp search(_, _, min, max) when min > max, do: :not_found

  defp search(numbers, key, min, max) do
    index = min + div(max - min, 2) # protects against int overflow
    case elem(numbers, index) do
      el when el > key -> search(numbers, key, min, index - 1)
      el when el < key -> search(numbers, key, index + 1, max)
      _ -> {:ok, index}
    end
  end
end
