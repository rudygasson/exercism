defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    checkout_date = NaiveDateTime.to_date(checkout_datetime)

    case before_noon?(checkout_datetime) do
      true -> Date.add(checkout_date, 28)
      false -> Date.add(checkout_date, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    actual_return_datetime
    |> Date.diff(planned_return_date)
    |> max(0)
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
