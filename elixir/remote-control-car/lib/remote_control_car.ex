defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname,
    battery_percentage: 100,
    distance_driven_in_meters: 0]

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: batt_p}) do
    case batt_p do
      0 -> "Battery empty"
      _ -> "Battery at #{batt_p}%"
    end
  end

  def drive(%RemoteControlCar{
    distance_driven_in_meters: distance,
    battery_percentage: batt_p} = remote_car) do
    case batt_p do
      0 -> remote_car
      _ -> %RemoteControlCar{ remote_car |
              distance_driven_in_meters: distance + 20,
              battery_percentage: batt_p - 1
            }
    end
  end
end
