defmodule Deck do
  import Card
  @suits ["Spades", "Heart", "Club", "Diamonds"]
  @rank ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "Jack", "King", "Queen"]

  def build_deck do
    recursive_deck_build(@rank)
  end

  defp recursive_deck_build([rank_head | rank_tail]) do
    [
      %Card{suit: "Spades", rank: rank_head},
      %Card{suit: "Heart", rank: rank_head},
      %Card{suit: "Club", rank: rank_head},
      %Card{suit: "Diamonds", rank: rank_head} |
       recursive_deck_build(rank_tail)
    ]
  end
  defp recursive_deck_build([]) do
    []
  end

end
