defmodule Player do
  use GenServer

  def handle_call(:lookup, _from, _state) do
    {:reply, "la", nil}
  end

end
