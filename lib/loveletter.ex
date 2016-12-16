defmodule Loveletter do

  def start_player( hand ) do
    {:ok, pid} = GenServer.start_link( Player, hand )
    pid
  end

  def get_player_hand(pid) do
    GenServer.call( pid, :get_hand )
  end

  def remove_top_card(pid) do
    GenServer.cast( pid, :remove_top_card )
  end

  def add_card(pid, card) do
    GenServer.cast( pid, { :add_card, card } )
  end

  def move_card( from, to ) do
    card = GenServer.call( from, :remove_top_card )
    GenServer.cast( to, { :add_card, card } )
  end

  def shuffle_cards( pid ) do
    GenServer.cast( pid, :shuffle_cards )
  end


end
