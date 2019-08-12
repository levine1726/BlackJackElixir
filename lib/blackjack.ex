defmodule Blackjack do
  @moduledoc """
  Documentation for Blackjack.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Blackjack.hello()
      :world

  """
  def launch_game do
    Console.welcome_player()
    play_round()
  end

  defp play_round(deck \\ []) do
    # deal player and dealer hand, show dealer's one card
    {players_hand, deck} = Deck.deal_cards(deck)
    {dealers_hand, deck} = Deck.deal_cards(deck)
    Console.show_hand([List.first(dealers_hand)], :dealer)
    Console.show_hand(players_hand, :player)

    with {players_hand, :ok, deck} <- finalize_player_hand(players_hand, deck) do
      #if no bust, dealer plays his hand out
      Console.notify_dealer_playing()
      {dealers_hand, is_bust, deck} = play_dealers_hand(dealers_hand, deck)
      case is_bust do
        true -> notify_dealer_busted(dealers_hand)
        false -> calculate_winner(players_hand, dealers_hand)
      end
      end_round(deck)
    else
      {players_hand, :bust, deck} -> players_hand |> notify_player_bust(deck)
    end
  end

  defp notify_dealer_busted(dealers_hand) do
    Console.show_hand(dealers_hand, :dealer)
    points = dealers_hand |> Card.calculate_hand()
    Console.notify_bust(points, :dealer)
  end

  defp calculate_winner(players_hand, dealers_hand) do
    Console.show_hand(dealers_hand, :dealer)
    player_points = players_hand |> Card.calculate_hand()
    dealer_points = dealers_hand |> Card.calculate_hand()
    cond do
      player_points > dealer_points -> Console.notify_player_win()
      player_points == dealer_points -> Console.notify_tie()
      true -> Console.notify_player_loss()
    end
  end

  defp play_dealers_hand(dealers_hand, deck) do
    points = dealers_hand |> Card.calculate_hand()
    case points |> Card.next_dealer_action() do
      :bust -> {dealers_hand, true, deck}
      :stay -> {dealers_hand, false, deck}
      :hit -> dealer_takes_hit(dealers_hand, deck)
    end
  end

  defp dealer_takes_hit(dealers_hand, deck) do
    {new_card, deck} = Deck.deal_cards(deck, :hit)
    new_hand = [List.first(new_card) | dealers_hand]
    play_dealers_hand(new_hand, deck)
  end

  defp notify_player_bust(players_hand, deck) do
    final_score = players_hand
      |> Card.calculate_hand()

    Console.notify_bust(final_score, :player)
    end_round(deck)
  end


  defp finalize_player_hand(player_hand, deck) do
    player_action = Console.request_player_action()
    case player_action do
      :hit -> draw_card_and_check_bust(player_hand, deck)
      :stay -> {player_hand, :ok, deck}
    end
  end

  defp draw_card_and_check_bust(player_hand, deck) do
    {new_card, new_deck} = Deck.deal_cards(deck, :hit)

    new_hand = [List.first(new_card) | player_hand]
    Console.show_hand(new_hand, :player)
    points = Card.calculate_hand(new_hand)

    cond do
      points > 21 -> {new_hand, :bust, new_deck}
      true -> finalize_player_hand(new_hand, new_deck)
    end
  end

  defp end_round(deck) do
    play_again? = Console.request_new_round()
    case play_again? do
      true -> play_round(deck)
      false -> Console.end_game()
    end
  end
end

Blackjack.launch_game()
