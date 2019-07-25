defmodule ConsoleTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO

  test "print dealer hand" do
    card_1 = %Card{suit: "Spades", rank: "Ace"}
    card_2 = %Card{suit: "Hearts", rank: "Queen"}

    fun = fn ->
      Console.show_hand(card_1, card_2, :dealer)
    end

    assert capture_io(fun) == "Dealer has a Ace of Spades, and a Queen of Hearts"
  end

  test "print player hand" do
    card_1 = %Card{suit: "Spades", rank: "Ace"}
    card_2 = %Card{suit: "Hearts", rank: "Queen"}

    fun = fn ->
      Console.show_hand(card_1, card_2, :player)
    end

    assert capture_io(fun) == "You have a Ace of Spades, and a Queen of Hearts"
  end

  test "print dealer dealer's face up command" do
    card_1 = %Card{suit: "Spades", rank: "Ace"}

    fun = fn ->
      Console.show_hand(card_1, :dealer)
    end

    assert capture_io(fun) == "Dealer has a Ace of Spades"
  end
end
