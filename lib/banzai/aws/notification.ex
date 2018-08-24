defmodule Banzai.Aws.Notification do
  @moduledoc """
  Generic AWS Config (JSON) notification struct.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Banzai.Aws.Notification

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "notifications" do
    field(:message, :string)
    field(:message_id, :string)
    field(:signature, :string)
    field(:signature_version, :string)
    field(:signing_cert_url, :string)
    field(:subject, :string)
    field(:timestamp, :string)
    field(:topic_arn, :string)
    field(:type, :string)
    field(:unsubscribe_url, :string)

    timestamps()
  end

  @doc false
  def changeset(%Notification{} = notification, attrs) do
    notification
    |> cast(attrs, [
      :message,
      :message_id,
      :signature,
      :signature_version,
      :signing_cert_url,
      :subject,
      :timestamp,
      :topic_arn,
      :type,
      :unsubscribe_url
    ])
    |> validate_required([
      :message,
      :message_id,
      :signature,
      :signature_version,
      :signing_cert_url,
      :subject,
      :timestamp,
      :topic_arn,
      :type,
      :unsubscribe_url
    ])
  end
end
