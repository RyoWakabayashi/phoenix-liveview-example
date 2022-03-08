defmodule LiveViewExampleWeb.GaugeBlock do
  @moduledoc """
  ゲージブロック
  """

  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div id={@id} class={@class_name}></div>
    """
  end
end
