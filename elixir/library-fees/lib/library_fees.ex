defmodule LibraryFees do
  def datetime_from_string(string) do
    {_, date_time} = NaiveDateTime.from_iso8601(string)
    date_time
  end

  def before_noon?(datetime) do
    Time.before?(NaiveDateTime.to_time(datetime), ~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> before_noon?
    |> case do
        true -> NaiveDateTime.to_date(checkout_datetime)
          |> Date.add(28)
        false -> NaiveDateTime.to_date(checkout_datetime)
          |> Date.add(29)
      end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    cond do
      Date.diff(actual_return_datetime, planned_return_date) <= 0 -> 0
      true -> Date.diff(actual_return_datetime, planned_return_date)
    end
  end

  def monday?(datetime) do
    Date.day_of_week(NaiveDateTime.to_date(datetime)) == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    checkout = return_date(datetime_from_string(checkout))
    return = datetime_from_string(return)
    fee = days_late(checkout, return) * rate
    cond do
      monday?(return) -> div(fee, 2)
      true -> fee
    end
  end
end
