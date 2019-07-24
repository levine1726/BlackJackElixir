defmodule DeckTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  import Deck

  test "print dealer hand" do
    deck = Deck.build_deck()
    IO.inspect deck
     assert length(deck) == 52
  end
end
