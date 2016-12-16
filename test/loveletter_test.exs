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

  test "moves card by id" do
    did = Loveletter.start_player( [1,2] )
    pid = Loveletter.start_player( [] )
    Loveletter.move_card( did, pid, 2 )
    assert [1] == Loveletter.get_player_hand( did )
    assert [2] == Loveletter.get_player_hand( pid )
  end

  test "wont move card if doesn't exist" do
    did = Loveletter.start_player( [1,2] )
    pid = Loveletter.start_player( [] )
    result = Loveletter.move_card( did, pid, 7 )
    assert :no_card == result
  end

  test "doesnt change state if card doesn't exist" do
    did = Loveletter.start_player( [1,2] )
    pid = Loveletter.start_player( [] )
    Loveletter.move_card( did, pid, 7 )
    assert [1,2] == Loveletter.get_player_hand( did )
    assert [] == Loveletter.get_player_hand( pid )
  end

  #game tests
  test "can setup deck" do
    deck_id = Loveletter.start_player( [1,1,1,1,1,2,2,3,3,4,4,5,6,7,8] )
    assert [1,1,1,1,1,2,2,3,3,4,4,5,6,7,8] == Loveletter.get_player_hand( deck_id )
  end

  test "player can take card from deck" do
    player_id = Loveletter.start_player( [] )
    deck_id = Loveletter.start_player( [1,1,1,1,1,2,2,3,3,4,4,5,6,7,8] )
    Loveletter.move_card(deck_id, player_id)
    assert [1] == Loveletter.get_player_hand( player_id )
  end


end
