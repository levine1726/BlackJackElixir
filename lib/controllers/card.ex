defmodule Card do
  @enforce_keys [:suit, :rank]
  defstruct [:suit, :rank]
end
