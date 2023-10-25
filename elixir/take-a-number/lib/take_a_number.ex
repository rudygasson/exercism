defmodule TakeANumber do
  def start() do
    spawn(fn -> loop(0) end)
  end

  defp loop(state) do
    receive do
      {:report_state, sender_id} ->
        send(sender_id, state)
        loop(state)
      {:take_a_number, sender_id} ->
        send(sender_id, state = state + 1)
        loop(state)
      :stop -> nil
      _ -> loop(state)
    end
  end
end
