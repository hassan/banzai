defmodule Banzai.Aws.SubscriptionConfirmation do
  use Ecto.Schema
  import Ecto.Changeset
  alias Banzai.Aws.SubscriptionConfirmation

  @moduledoc """
  {
    "Type" : "SubscriptionConfirmation",
    "MessageId" : "889d9268-248e-47d8-b5db-bd486a26d3c7",
    "Token" : "2336412f37fb687f5d51e6e241d59b69a74b7514b923e5d32135809a897dacde04cc082ff6adfc711b5dd22e335add2c81a9e9473a4c408e8f68a1b72823a617d8c523ca5ad795f343245921693bd761141b229f835d7d4753f0af2830b986e430756e7cca385871995a8a72c2906590431f7a99496e650f765d6880a8df3b8f",
    "TopicArn" : "arn:aws:sns:us-west-2:917568727384:config-topic-us-west-2",
    "Message" : "You have chosen to subscribe to the topic arn:aws:sns:us-west-2:917568727384:config-topic-us-west-2.\nTo confirm the subscription, visit the SubscribeURL included in this message.",
    "SubscribeURL" : "https://sns.us-west-2.amazonaws.com/?Action=ConfirmSubscription&TopicArn=arn:aws:sns:us-west-2:917568727384:config-topic-us-west-2&Token=2336412f37fb687f5d51e6e241d59b69a74b7514b923e5d32135809a897dacde04cc082ff6adfc711b5dd22e335add2c81a9e9473a4c408e8f68a1b72823a617d8c523ca5ad795f343245921693bd761141b229f835d7d4753f0af2830b986e430756e7cca385871995a8a72c2906590431f7a99496e650f765d6880a8df3b8f",
    "Timestamp" : "2017-10-11T23:50:16.474Z",
    "SignatureVersion" : "1",
    "Signature" : "YxuE3cDqtw0FJlARXz2/3hGOnY6S9mYeRHpowgHhXnT3zSH8ns1MtWiF0bsI0JQF8Z6OWOJ2asMtvIucjcR+tu4l5QWa2yqJUVXXXRkeOH0+ApbgRoMdArOAhjezONgXlVPZqPlWPkILwbGCHxiumnbpK3smni7mdOS4hoIKW71pXDtKzuMxHJczkk1lbXbpl/zSGZpXGeUP7DTUVPbQziYxbYkDjCziqLD6hBOUaagYM40bJMV8k0mGRcbCQqOn7X2avOd6mqM+irY3+iFQ4D0+uB2p69of75UINcjUuO5dgGTwojMQVB7tJW5bXP2Zipv+Q3pl/bru20h2H34SlA==",
    "SigningCertURL" : "https://sns.us-west-2.amazonaws.com/SimpleNotificationService-433026a4050d206028891664da859041.pem"
  }
  """
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "subscription_confirmations" do
    field(:message, :string)
    field(:message_id, :string)
    field(:signature, :string)
    field(:signature_version, :string)
    field(:signing_cert_url, :string)
    field(:token, :string)
    field(:timestamp, :string)
    field(:topic_arn, :string)
    field(:type, :string)
    field(:subscribe_url, :string)
    timestamps()
  end

  @doc false
  def changeset(%SubscriptionConfirmation{} = subscription_confirmation, attrs) do
    subscription_confirmation
    |> cast(attrs, [
      :message,
      :message_id,
      :signature,
      :signature_version,
      :signing_cert_url,
      :token,
      :timestamp,
      :topic_arn,
      :type,
      :subscribe_url
    ])
    |> validate_required([
      :message,
      :message_id,
      :signature,
      :signature_version,
      :signing_cert_url,
      :token,
      :timestamp,
      :topic_arn,
      :type,
      :subscribe_url
    ])
  end
end
