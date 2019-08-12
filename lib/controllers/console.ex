defmodule Console do
  def welcome_player() do
    IO.puts(
      "Welcome to Blackjack! You will be playing against a dealer which must hit to hard 17!\n"
    )
  end

  def end_game() do
    IO.puts("Thanks for playing! Come back to the casino soon!")
  end

  def show_hand([card1], :dealer = _player) do
    IO.puts("Dealer has a #{print_card(card1)} showing")
  end
  def show_hand([card1, card2], :dealer = _player) do
    score = [card1, card2] |> Card.calculate_hand()
    IO.puts("Dealer has a #{print_card(card1)}, and a #{print_card(card2)} (#{score})")
  end


  def show_hand([card1, card2] = cards, :player = _player) do
    score = cards |> Card.calculate_hand()
    cards_as_string = calculate_card_array_string([card1, card2])
    IO.puts("You have a #{print_card(card1)}, and a #{print_card(card2)} (#{score})")
  end

  def show_hand(card_array, :player = _player) do
    score = card_array |> Card.calculate_hand()
    cards_as_string = calculate_card_array_string(card_array)
    IO.puts("You have: " <> cards_as_string <> " (#{score})")
  end

  def notify_player_win() do
    IO.puts("You won! Nice!")
  end

  def notify_tie() do
    IO.puts("You both tied!")
  end

  def notify_player_loss() do
    IO.puts("Dealer wins! You lost!")
  end

  def show_hand(card_array, :dealer = _player) do
    score = card_array |> Card.calculate_hand()
    cards_as_string = calculate_card_array_string(card_array)
    IO.puts("Dealer has: " <> cards_as_string <> " (#{score})")
  end

  defp calculate_card_array_string(card_array) do
    card_array
      |> Enum.map(fn(card) -> card |> print_card() end)
      |> Enum.join(", ")
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

  def notify_dealer_playing do
    IO.puts("Dealer playing out hand...")
    Process.sleep(1000)
  end

  defp request_player_action(:error = _error) do
    IO.puts("What? Can you read?. That's not a valid move.")
    request_player_action()
  end
  def request_player_action do
    action = IO.gets("Your move: would you like to hit or stay? Enter h for hit, or s for stay\n")
    case action do
      "h\n" -> :hit
      "s\n" -> :stay
      _ -> request_player_action(:error)
    end
  end

  defp request_new_round(:error = _error) do
    IO.puts("What? Can you read?. That's not a valid move.")
    request_new_round()
  end
  def request_new_round() do
    action = IO.gets("Would you like to play again? (y/n)\n")
    case action do
      "y\n" -> true
      "n\n" -> false
      _ -> request_new_round(:error)
    end
  end

  defp print_card(card), do: "#{card.rank} of #{card.suit}"
end
