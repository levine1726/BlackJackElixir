defmodule ConsoleTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  import Card
  import Console

  test "print dealer hand" do
    card_1 = %Card{suit: "Spades", rank: "Ace"}
    card_2 = %Card{suit: "Hearts", rank: "Queen"}

    fun = fn ->
      Console.show_hand(card_1, card_2, :dealer)
    end

    assert capture_io(fun) == "Dealer has an Ace of Spades, and a Queen of Hearts"
  end

  test "print dealer dealer's face up command" do
    card_1 = %Card{suit: "Spades", rank: "Ace"}

    fun = fn ->
      Console.show_hand(card_1, :dealer)
    end

    assert capture_io(fun) == "Dealer has an Ace of Spades"
  end

  test "request player action and receive hit" do
    expected_message = "Your move: would you like to hit or stay? Enter h for hit, or s for stay\n"
    fun = fn ->
      assert capture_io(fn -> Console.request_player_action() end) == expected_message
    end
    assert capture_io("h", fun) == :hit
  end

  test "request player action and receive stay" do
    expected_message = "Your move: would you like to hit or stay? Enter h for hit, or s for stay\n"
    fun = fn ->
      assert capture_io(fn -> Console.request_player_action() end) == expected_message
    end
    assert capture_io("s", fun) == :stay
  end

  test "request player action and receive junk" do
    expected_message = "Your move: would you like to hit or stay? Enter h for hit, or s for stay\n"
    fun = fn ->
      assert capture_io(fn -> Console.request_player_action() end) == expected_message
    end
    assert capture_io("bleh", fun) == :error
  end
end
