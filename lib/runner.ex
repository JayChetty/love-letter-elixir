defmodule Runner do
  use Application

  def card_number_to_name(number) do
    map = %{
      1 => "Guard(1)",
      2 => "Priest(2)",
      3 => "Baron(3)",
      4 => "Handmaid(4)",
      5 => "Prince(5)",
      6 => "King(6)",
      7 => "Countess(7)",
      8 => "Princess(8)"
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
    show_cards(deck_id, "Deck")


    player_one_id = Loveletter.start_player( [] )
    player_two_id = Loveletter.start_player( [] )

    IO.puts("Dealing Cards")
    Loveletter.move_card(deck_id, player_one_id)
    Loveletter.move_card(deck_id, player_two_id)

    show_cards(player_one_id, "Player One")
    show_cards(player_two_id, "Player Two")

    discard_pile = Loveletter.start_player( [] )

    IO.gets("Player One Pick Up")
    Loveletter.move_card(deck_id, player_one_id)
    show_cards(player_one_id, "Player One")
    IO.puts("Play card ( Enter Number )")
    
    Loveletter.move_card(deck_id, player_two_id)



    #because
    Task.start(fn -> :timer.sleep(1); IO.puts("done sleeping") end)
  end

  def show_cards(pid, holder_name) do
    cards = Loveletter.get_player_hand( pid )
    IO.puts("#{holder_name} Cards #{ inspect card_names( cards ) }")
  end

end
