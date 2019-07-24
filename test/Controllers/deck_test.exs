defmodule DeckTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  import Deck
  import Card

  test "build dealer hand" do
    deck = Deck.build_deck()
    assert length(deck) == 52
    # check for some sample cards
    test_cards = [
      %Card{suit: "Hearts", rank: "10"},
      %Card{suit: "Diamonds", rank: "Ace"},
      %Card{suit: "Spades", rank: "Jack"},
      %Card{suit: "Clubs", rank: "3"}
    ]

    test_cards |>
    Enum.each(fn test_card -> assert Enum.member?(deck, test_card) end)
  end

  test "deal two cards from deck" do
    deck = Deck.build_deck()
    {cards, new_deck} = Deck.deal_cards(deck)
    assert length(cards) == 2
    assert length(new_deck) == 50
  end

  test "deal hit from deck" do
    deck = Deck.build_deck()
    {card, new_deck} = Deck.deal_cards(deck, :hit)
    assert length(card) == 1
    assert length(new_deck) == 51
  end
end
