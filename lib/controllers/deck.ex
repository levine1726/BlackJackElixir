defmodule Deck do
  import Card
  @suits ["Spades", "Hearts", "Clubs", "Diamonds"]
  @rank ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "King", "Queen"]

  def build_deck do
    build_suits(@suits, []) |> Enum.shuffle()
  end

  def deal_cards(deck) do
    Enum.split(deck, 2)
  end

  def deal_cards(deck, :hit = _deal_type) do
    Enum.split(deck, 1)
  end

  defp build_suits([suit_head | suit_tail], results) do
    build_suits(suit_tail, assign_ranks(suit_head, @rank, results))
  end

  defp build_suits([], results), do: results

  defp assign_ranks(suit, [rank_head | rank_tail], results) do
    card = %Card{suit: suit, rank: rank_head}
    assign_ranks(suit, rank_tail, [card | results])
  end
  defp assign_ranks(_suit, [], results), do: results

end
