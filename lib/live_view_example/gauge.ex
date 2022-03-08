defmodule LiveViewExample.Gauge do
  @moduledoc """
  ゲージのバックエンド処理を定義する
  """

  use GenServer
  alias Phoenix.PubSub

  @name :gauge_server

  @start_value 0

  # -------  External API (runs in client process) -------

  @spec topic :: <<_::40>>
  def topic do
    "guage"
  end

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, @start_value, name: @name)
  end

  def current do
    GenServer.call(@name, :current)
  end

  def init(start_num_blocks) do
    :timer.send_interval(1000, :incr)
    {:ok, start_num_blocks}
  end

  def handle_call(:current, _from, count) do
    {:reply, count, count}
  end

  def handle_info(:incr, num_blocks) do
    new_num_blocks =
      if num_blocks > 99 do
        0
      else
        num_blocks + 1
      end

    PubSub.broadcast(LiveViewExample.PubSub, topic(), {:num_blocks, new_num_blocks})
    {:noreply, new_num_blocks}
  end
end
