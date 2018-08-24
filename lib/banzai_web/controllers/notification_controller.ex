defmodule BanzaiWeb.NotificationController do
  use BanzaiWeb, :controller
  require Logger
  require IEx
  alias Banzai.Aws.Notification
  alias Banzai.Aws.SubscriptionConfirmation

  action_fallback BanzaiWeb.FallbackController

  def create(conn, params) when is_map(params) do
    with {:ok, body, _} <- Plug.Conn.read_body(conn, []),
         {:ok, notification_params} <- Poison.decode(body),
         {:ok, type} <- Map.fetch(notification_params, "Type") do
           case type do
             "SubscriptionConfirmation" -> confirm_with(conn, notification_params)
             "Notification" -> save_notification(conn, notification_params)
             _ -> save_and_ignore(conn, notification_params)
           end
         end
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Poison.encode!(%{}))
  end

  defp confirm_with(conn, notification_params) do
    with {:ok, %SubscriptionConfirmation{} = _confirmation} <- Banzai.Aws.create_subscription_confirmation(notification_params),
         {:ok, fetch_url} <- Map.fetch(notification_params, "SubscribeURL"),
         {:ok, _response} <- HTTPoison.get(fetch_url) do
          Logger.info(fn -> "CONFIRMED" end)
        else
          x -> Logger.error(fn -> "X: #{x}" end)
        end
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Poison.encode!(%{}))
  end

  defp save_notification(conn, notification_params) do
    with {:ok, %Notification{} = _notification} <- Banzai.Aws.create_notification(notification_params) do
      conn
      |> put_resp_content_type("application/json")
      |> send_resp(201, Poison.encode!(%{}))
    else
      _ -> save_and_ignore(conn, notification_params)
    end
  end

  defp save_and_ignore(conn, notification_params) do
    Logger.info(fn -> "DEAD #{Poison.encode!(notification_params)}" end)
    Banzai.Aws.stash_raw_notification(Poison.encode!(notification_params))
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Poison.encode!(%{}))
  end
end
