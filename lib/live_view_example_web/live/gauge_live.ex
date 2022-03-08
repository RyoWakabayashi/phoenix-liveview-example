defmodule LiveViewExampleWeb.GaugeLive do
  @moduledoc """
  ゲージのフロントエンド処理を定義する
  """

  use Phoenix.LiveView
  alias LiveViewExample.Gauge
  alias LiveViewExampleWeb.GaugeView
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
        "gauge-block none"

      index >= 80 ->
        "gauge-block high"

      true ->
        "gauge-block"
    end
  end

  def render(assigns) do
    GaugeView.render("index.html", assigns)
  end
end
