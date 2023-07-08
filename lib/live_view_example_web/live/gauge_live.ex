defmodule LiveViewExampleWeb.GaugeLive do
  @moduledoc """
  ゲージのフロントエンド処理を定義する
  """

  use LiveViewExampleWeb, :live_view
  alias LiveViewExample.Gauge
  alias Phoenix.PubSub

  @topic Gauge.topic()

  defmodule Block do
    @moduledoc """
    ゲージブロック
    """
    defstruct [:id, :class_name]
  end

  def mount(_params, _session, socket) do
    PubSub.subscribe(LiveViewExample.PubSub, @topic)

    num_blocks = Gauge.current()

    blocks =
      num_blocks
      |> generate_blocks

    {:ok, assign(socket, num_blocks: num_blocks, blocks: blocks)}
  end

  def handle_info({:num_blocks, num_blocks}, socket) do
    blocks =
      num_blocks
      |> generate_blocks

    {:noreply, assign(socket, num_blocks: num_blocks, blocks: blocks)}
  end

  def generate_blocks(num_blocks) do
    Enum.map(0..99, fn index ->
      %Block{id: "block-#{index}", class_name: class_name(index, num_blocks)}
    end)
  end

  def class_name(index, num_blocks) do
    cond do
      index > num_blocks ->
        "w-[100px] h-[3px] mb-[1px] invisible"

      index >= 80 ->
        "w-[100px] h-[3px] mb-[1px] bg-[#f00]"

      true ->
        "w-[100px] h-[3px] mb-[1px] bg-[#0f0]"
    end
  end

  def render(assigns) do
    ~H"""
    <div class="flex justify-center w-full h-[500px]">
      <div class="flex items-center justify-between w-52">
        <div class="w-16 text-3xl font-medium text-right">
          <%= @num_blocks %>
        </div>
        <div class="w-[100px] h-[400px]">
          <%= for block <- @blocks do %>
            <%= live_component LiveViewExampleWeb.GaugeBlock,
              id: block.id,
              class_name: block.class_name %>
          <% end %>
        </div>
      </div>
    </div>
    """
  end
end
