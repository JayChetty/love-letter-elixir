defmodule Player do
  use GenServer
  require Logger

  def handle_call(:get_hand, _from, hand) do
    {:reply, hand, hand}
  end

  def handle_call(:remove_top_card, _from, [ top_card | rest_of_hand ]) do
    {:reply, top_card, rest_of_hand}
  end

  def handle_cast(:remove_top_card, [ _top_card | rest_of_hand ]) do
    {:noreply, rest_of_hand}
  end

  def handle_cast({ :add_card, card }, hand) do
    { :noreply, [ card | hand ] }
  end

  def handle_cast( :shuffle_cards, hand) do
    { :noreply, Enum.shuffle( hand ) }
  end

end
