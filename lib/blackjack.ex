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
      IO.puts("You did not bust!\n\n-----------------------")
      Console.show_hand(players_hand, :player)

    else
      {players_hand, :bust, deck} -> players_hand |> notify_player_bust()
    end


    #show dealer result

    # ask to play again or quit
  end

  defp notify_player_bust(players_hand) do
    final_score = players_hand
      |> Card.calculate_hand()

    Console.notify_bust(final_score, :player)
    end_round()
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

  defp end_round() do
    # show dealer hand
    #ask user to play another round or to quit
    Console.end_game()
  end
end

Blackjack.launch_game()
