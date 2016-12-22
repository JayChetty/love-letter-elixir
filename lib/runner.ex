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
    IO.puts("Love Letter")

    {number_of_players,_} = IO.gets("Enter Number of Players ") |> Integer.parse

    players = Enum.map( 1..number_of_players, fn(number)->
      %{name: "Player #{number}", id: Loveletter.start_player( [] )}
    end)

    # deck_id = Loveletter.start_player( [1,1,1,1,1,2,2,3,3,4,4,5,5,6,7,8] )
    deck_id = Loveletter.start_player( [1,1,7,8] )


    IO.puts("Shuffling")
    Loveletter.shuffle_cards( deck_id )
    show_cards(deck_id, "Deck")

    IO.puts("Dealing Cards")
    Enum.each(players, fn(player)->
      Loveletter.move_card(deck_id, player.id)
    end)

    discard_id = Loveletter.start_player( [] )


    deck = Loveletter.get_player_hand( deck_id )
    play_turns(deck, deck_id, discard_id, players)


    Task.start(fn -> :timer.sleep(1); IO.puts("done sleeping") end)
  end

  def play_turns([], deck_id, discard_id, players, _player_index) do
    IO.puts("GAME IS OVER")
    Enum.each(players, fn(player)->
      show_cards(player.id, player.name)
    end)
  end
  #
  def play_turns(deck, deck_id, discard_id, players, player_index \\ 0) do
    play_turn(  deck_id, discard_id, Enum.at( players, player_index ) )
    updated_deck = Loveletter.get_player_hand( deck_id )
    next_player_index = rem(player_index + 1, Enum.count(players) )
    IO.puts("Updated deck #{ inspect updated_deck }")
    play_turns( updated_deck, deck_id, discard_id, players, next_player_index )
  end

  def play_turn( deck_id, discard_id, player ) do
    IO.gets("#{player.name} Pick Up")
    Loveletter.move_card(deck_id, player.id)
    show_cards(player.id, player.name)
    place_card(player, discard_id)
  end

  def place_card(player, discard_id) do
    {card_to_place, :ok } = IO.gets("Play card ( Enter Number )") |> Integer.parse

    IO.puts("Playing Card #{ inspect card_to_place }")
    result = Loveletter.move_card(player.id, discard_id, card_to_place)

    case result do
      :ok ->
        IO.puts("Card has been placed")
      :no_card ->
        IO.puts("You don't have that card my friend")
        place_card(player, discard_id)
    end
  end

  def show_cards(pid, holder_name) do
    cards = Loveletter.get_player_hand( pid )
    IO.puts("#{holder_name} Cards #{ inspect card_names( cards ) }")
  end



end
