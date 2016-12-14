defmodule LoveletterTest do
  use ExUnit.Case
  doctest Loveletter

  test "the truth" do
    assert "la" == Loveletter.start()
  end
end
