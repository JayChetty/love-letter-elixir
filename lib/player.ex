defmodule Player do
  use GenServer
  require Logger

  def handle_call(:get_hand, _from, hand) do
    {:reply, hand, hand}
  end

  def handle_call(:remove_top_card, _from, [ top_card | rest_of_hand ]) do
    {:reply, top_card, rest_of_hand}
  end

  def handle_call({:get_card, card}, _from, hand) do
    card_index = Enum.find_index(hand, fn(number)-> card == number end)
    list_with_card_removed = List.delete(hand, card)
    card = get_card(hand, card_index)
    # {card, list_with_card_removed} = List.pop_at( hand, card_index )#only available elixir 1.4
    {:reply, card, list_with_card_removed}
  end

  defp get_card(hand, nil) do
    nil
  end

  defp get_card(hand, index) do
    Enum.at(hand, index)
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
