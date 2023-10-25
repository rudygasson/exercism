defmodule NameBadge do
  def print(id, name, department) do
    get_id = if id, do: "[#{id}] - ", else: ""
    get_department = if department, do: department |> String.upcase, else: "OWNER"
    "#{get_id}#{name} - #{get_department}"
  end
end
