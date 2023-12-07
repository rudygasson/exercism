defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, &(&1.price), :asc)
  end

  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price == nil))
  end

  def update_names(inventory, old_word, new_word) do
    Enum.map(inventory, fn item ->
      Map.update(item, :name, "", fn name ->
        String.replace(name, old_word, new_word)
      end)
    end)
  end

  def increase_quantity(item, count) do
    increase = fn {k,v} -> {k, v + count} end
    Map.update(item, :quantity_by_size, 0, &(Map.new(&1, increase)))
  end

  def total_quantity(item) do
    # Please implement the total_quantity/1 function
  end
end
