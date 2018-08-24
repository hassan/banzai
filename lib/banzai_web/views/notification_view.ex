defmodule BanzaiWeb.NotificationView do
  use BanzaiWeb, :view
  alias BanzaiWeb.NotificationView

  def render("index.json", %{notifications: notifications}) do
    %{data: render_many(notifications, NotificationView, "notification.json")}
  end

  def render("show.json", %{notification: notification}) do
    %{data: render_one(notification, NotificationView, "notification.json")}
  end

  def render("notification.json", %{notification: notification}) do
    %{id: notification.id,
      message: notification.message,
      message_id: notification.message_id,
      signature: notification.signature,
      signature_version: notification.signature_version,
      signing_cert_url: notification.signing_cert_url,
      subject: notification.subject,
      timestamp: notification.timestamp,
      topic_arn: notification.topic_arn,
      type: notification.type,
      unsubscribe_url: notification.unsubscribe_url}
  end
end
