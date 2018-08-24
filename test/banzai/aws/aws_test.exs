defmodule Banzai.AwsTest do
  use Banzai.DataCase
  alias Banzai.Aws
  alias Banzai.Aws.Notification
  alias Banzai.Aws.Convert

  describe "notifications" do

    @valid_attrs %{
      "Type": "some type",
      "MessageId": "some message_id",
      "TopicArn": "some topic_arn",
      "Subject": "some subject",
      "Message": "some message",
      "Timestamp": "some timestamp",
      "SignatureVersion": "some signature_version",
      "Signature": "some signature",
      "SigningCertURL": "some signing_cert_url",
      "UnsubscribeURL": "some unsubscribe_url"
    }

    def notification_fixture(attrs \\ %{}) do
      {:ok, notification} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Aws.create_notification()
      notification
    end

    test "create_notification/1 with valid data creates a notification" do
      assert {:ok, %Notification{} = notification} = Aws.create_notification(@valid_attrs)
      # assert {:ok, notification} = Aws.create_notification(@valid_attrs)
      assert notification.message == "some message"
      #  assert notification.message_id == "some message_id"
      #  assert notification.signature == "some signature"
      #  assert notification.signature_version == "some signature_version"
      #  assert notification.signing_cert_url == "some signing_cert_url"
      #  assert notification.subject == "some subject"
      #  assert notification.timestamp == "some timestamp"
      #  assert notification.topic_arn == "some topic_arn"
      #  assert notification.type == "some type"
      #  assert notification.unsubscribe_url == "some unsubscribe_url"
    end
  end

  describe "message_bodies" do

    @message_with_string_vals %{
      "configurationItem" => "dog",
      "configurationItemDiff" => "cat",
      "messageType" => "message type",
      "notificationCreationTime" => "2017-09-29T19:44:15.453Z",
      "recordVersion" => "1.2"
    }

    @message_with_map_vals %{
      "configurationItem": %{"dog": "Buster"},
      "configurationItemDiff": "cat",
      "messageType": "message type",
      "notificationCreationTime": "2017-09-29T19:44:15.453Z",
      "recordVersion": "1.2"
    }

    test "message body with strings is converted" do
      map = Convert.ed(@message_with_string_vals)
      assert get_in(map, [:message_type]) == "message type"
    end

    test "message body with maps is converted" do
      map = Convert.ed(@message_with_map_vals)
      # IO.inspect(map)
      assert get_in(map, [:configuration_item, :dog]) == "Buster"
    end
  end
end
