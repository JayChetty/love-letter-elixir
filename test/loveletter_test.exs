defmodule LoveletterTest do
  use ExUnit.Case
  doctest Loveletter

  test "can get player hand" do
    pid = Loveletter.start_player( [1,1] )
    assert [1,1] == Loveletter.get_player_hand( pid )
  end

  test "remove top card" do
    pid = Loveletter.start_player( [1,1] )
    Loveletter.remove_top_card( pid )
    #Can this suffer from race condition - card gets removed after we ask for hand?
    assert [1] == Loveletter.get_player_hand( pid )
  end

  test "add card" do
    pid = Loveletter.start_player( [1,1] )
    #Again race condition?
    Loveletter.add_card( pid, 8 )
    assert [8,1,1] == Loveletter.get_player_hand( pid )
  end


end
