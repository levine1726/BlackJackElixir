defmodule CardTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  import Card

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

    assert calculate_hand([card_1, card_2]) == 16
  end
end
