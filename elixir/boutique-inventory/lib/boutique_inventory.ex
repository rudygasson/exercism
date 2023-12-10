defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(!&1.price))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      new_name = String.replace(item.name, old_word, new_word)
      %{item | name: new_name}
    end)
  end

  def increase_quantity(item, count) do
    new_quantities =
      Map.new(
        item.quantity_by_size,
        fn {size, quantity} -> {size, quantity + count} end
      )
    %{item | quantity_by_size: new_quantities}
  end

  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_size, quantity}, sum -> sum + quantity end)
  end
end
