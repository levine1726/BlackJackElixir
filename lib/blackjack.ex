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

  def play_round(deck \\ []) do
    # deal player hand, show dealer's one card


    # prompt player to hit/stay

    #if no bust, dealer plays his hand out

    #show dealer result

    # ask to play again or quit
  end

  def end_game() do
    Console.end_game()
  end
end

Blackjack.launch_game()
