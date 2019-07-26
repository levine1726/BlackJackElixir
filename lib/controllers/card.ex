defmodule Card do
  @enforce_keys [:suit, :rank]
  defstruct [:suit, :rank]

  def calculate_hand(cards) do
    cards |>
      Enum.map(&get_rank_value/1) |>
      get_point_sum()
  end

  def next_dealer_action(points) do
    cond do
      points < 17 -> :hit
      true -> :stay
    end
  end

  defp get_point_sum(points) do
    points_sum = points
    |> Enum.reduce(0, fn(point, sum) -> sum + point end)
     cond do
      points_sum <= 21 -> points_sum
      points_sum > 21 && Enum.member?(points, 11) -> points |> decrease_one_ace_point() |> get_point_sum()
      true -> :bust
    end
  end

  defp decrease_one_ace_point(points) do
    [_eleven_pointer | tail_points] = points |> Enum.sort() |> Enum.reverse()
    [1 | tail_points]
  end

  defp get_rank_value(%Card{suit: _suit, rank: rank} = _card) do
    case rank do
      "Ace" -> 11
      "Jack" -> 10
      "Queen" -> 10
      "King" -> 10
      "10" -> 10
      "9" -> 9
      "8" -> 8
      "7" -> 7
      "6" -> 6
      "5" -> 5
      "4" -> 4
      "3" -> 3
      "2" -> 2
    end
  end
end
