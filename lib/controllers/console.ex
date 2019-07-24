defmodule Console do
  def show_hand(card1, card2, :dealer = _player) do
    IO.write("Dealer has a #{print_card(card1)}, and a #{print_card(card2)}")
  end

  def show_hand(card1, :dealer = _player) do
    IO.write("Dealer has a #{print_card(card1)}")
  end

  def show_hand(card1, card2, :player = _player) do
    IO.write("You have a #{print_card(card1)}, and a #{print_card(card2)}")
  end

  def request_player_action do
    action = IO.gets("Your move: would you like to hit or stay? Enter h for hit, or s for stay\n")
    case action do
      "h\n" -> :hit
      "s\n" -> :stay
      _ -> :error
    end

  end

  defp print_card(card), do: "#{card.rank} of #{card.suit}"
end
