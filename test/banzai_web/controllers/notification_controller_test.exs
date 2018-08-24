defmodule BanzaiWeb.NotificationControllerTest do
  use BanzaiWeb.ConnCase

  @attrs Poison.encode!(%{
    "Type": "Notification",
    "MessageId": "some message_id",
    "TopicArn": "some topic_arn",
    "Subject": "some subject",
    "Message": "some message",
    "Timestamp": "some timestamp",
    "SignatureVersion": "some signature_version",
    "Signature": "some signature",
    "SigningCertURL": "some signing_cert_url",
    "UnsubscribeURL": "some unsubscribe_url"
  })

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "content-type", "text/plain")}
  end

  describe "create notification" do
    test "returns 201 status when data is valid", %{conn: conn} do
      conn = post conn, notification_path(conn, :create), @attrs
      assert %{} = json_response(conn, 201)
    end
  end
end
