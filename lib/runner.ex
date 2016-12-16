defmodule Runner do
  use Application

  def card_number_to_name(number) do
    map = %{
      1 => "Guard",
      2 => "Priest",
      3 => "Baron",
      4 => "Handmaid",
      5 => "Prince",
      6 => "King",
      7 => "Countess",
      8 => "Princess"
    }

    map[number]
  end

  def card_names(cards) do
    Enum.map(cards, fn(card)-> card_number_to_name(card) end)
  end

  def start(_type, _args) do
    IO.puts("Gotta be starting something")
    # input = IO.gets("Enter please my friend  ")
    # IO.puts(input)
    deck_id = Loveletter.start_player( [1,1,1,1,1,2,2,3,3,4,4,5,5,6,7,8] )

    IO.puts("Shuffling")
    Loveletter.shuffle_cards( deck_id )
    show_cards(deck_id)


    player_one_id = Loveletter.start_player( [] )
    player_two_id = Loveletter.start_player( [] )

    IO.puts("Deal")
    Loveletter.move_card(deck_id, player_one_id)
    Loveletter.move_card(deck_id, player_two_id)

    show_cards(player_one_id)
    show_cards(player_two_id)



    #why why why
    Task.start(fn -> :timer.sleep(1); IO.puts("done sleeping") end)
  end

  def show_cards(pid) do
    cards = Loveletter.get_player_hand( pid )
    IO.puts("Player One Card #{ inspect card_names( cards ) }")
  end

end
