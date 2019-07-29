defmodule Console do
  def welcome_player() do
    IO.puts(
      "Welcome to Blackjack! You will be playing against a dealer which must hit to hard 17!\n"
    )
  end

  def end_game() do
    IO.puts("Thanks for playing! Come back to the casino soon!")
  end

  def show_hand([card1, card2], :dealer = _player) do
    IO.puts("Dealer has a #{print_card(card1)}, and a #{print_card(card2)}")
  end

  def show_hand([card1], :dealer = _player) do
    IO.puts("Dealer has a #{print_card(card1)} showing")
  end

  def show_hand([card1, card2] = cards, :player = _player) do
    score = cards |> Card.calculate_hand()
    IO.puts("You have a #{print_card(card1)}, and a #{print_card(card2)} (#{score})")
  end

  def show_hand(card_array, :player = _player) do
    score = card_array |> Card.calculate_hand()
    cards_as_string = card_array
      |> Enum.map(fn(card) -> card |> print_card() end)
      |> Enum.join(", ")
    IO.puts("You have: " <> cards_as_string <> " (#{score})")
  end

  def show_hand(card_array, :dealer = _player) do
    cards_as_string = card_array
      |> Enum.map(fn(card) -> card |> print_card() end)
      |> Enum.join(", ")
    IO.puts("Dealer has: " <> cards_as_string)
  end

  def notify_bust(points, actor) do
    case actor do
      :player -> IO.puts("You busted!")
      :dealer -> IO.puts("Dealer busted with a total of #{points}")
    end
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
