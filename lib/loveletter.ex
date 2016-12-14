defmodule Loveletter do
  def start do
    {:ok, pid} = GenServer.start_link(Player, :something)
    GenServer.call(pid, :lookup)
  end
end
