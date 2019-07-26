defmodule CardTest do
  use ExUnit.Case, async: true
  import Card

  describe "For a player hand" do
    test "calculate 10, 8" do
      card_1 = %Card{suit: "Hearts", rank: "10"}
      card_2 = %Card{suit: "Spades", rank: "8"}

      assert calculate_hand([card_1, card_2]) == 18
    end

    test "calculate 2, 2" do
      card_1 = %Card{suit: "Clubs", rank: "2"}
      card_2 = %Card{suit: "Diamonds", rank: "2"}

      assert calculate_hand([card_1, card_2]) == 4
    end

    test "calculate Ace, Jack" do
      card_1 = %Card{suit: "Spades", rank: "Ace"}
      card_2 = %Card{suit: "Diamonds", rank: "Jack"}

      assert calculate_hand([card_1, card_2]) == 21
    end

    test "calculate Ace, 2, Jack, 3" do
      card_1 = %Card{suit: "Spades", rank: "Ace"}
      card_2 = %Card{suit: "Clubs", rank: "2"}
      card_3 = %Card{suit: "Diamonds", rank: "Jack"}
      card_4 = %Card{suit: "Hearts", rank: "3"}

      assert calculate_hand([card_1, card_2, card_3, card_4]) == 16
    end

    test "calculate 10, 2, Jack" do
      card_1 = %Card{suit: "Spades", rank: "10"}
      card_2 = %Card{suit: "Clubs", rank: "2"}
      card_3 = %Card{suit: "Diamonds", rank: "Jack"}

      assert calculate_hand([card_1, card_2, card_3]) == :bust
    end

    test "calculate Ace, 10, 2, Jack" do
      card_1 = %Card{suit: "Spades", rank: "Ace"}
      card_2 = %Card{suit: "Spades", rank: "10"}
      card_3 = %Card{suit: "Clubs", rank: "2"}
      card_4 = %Card{suit: "Diamonds", rank: "Jack"}

      assert calculate_hand([card_1, card_2, card_3, card_4]) == :bust
    end

    test "calculate Ace, 10, Ace, 2, Jack" do
      card_1 = %Card{suit: "Spades", rank: "Ace"}
      card_2 = %Card{suit: "Spades", rank: "10"}
      card_3 = %Card{suit: "Hearts", rank: "Ace"}
      card_4 = %Card{suit: "Clubs", rank: "2"}
      card_5 = %Card{suit: "Diamonds", rank: "Jack"}

      assert calculate_hand([card_1, card_2, card_3, card_4, card_5]) == :bust
    end
  end

  describe "for dealer hand" do
    test "if dealer should stay" do
      dealer_points = 17
      assert next_dealer_action(dealer_points) == :stay
    end

    test "if dealer should hit" do
      dealer_points = 16
      assert next_dealer_action(dealer_points) == :hit
    end
  end
end
