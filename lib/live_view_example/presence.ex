defmodule LiveViewExample.Presence do
  @moduledoc """
  接続ユーザー数
  """

  use Phoenix.Presence,
    otp_app: :live_view_example,
    pubsub_server: LiveViewExample.PubSub
end
