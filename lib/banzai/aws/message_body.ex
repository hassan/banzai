defmodule Banzai.Aws.MessageBody do
  @moduledoc """
  Basic non-nested struct for Message field of Notification.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Banzai.Aws.MessageBody

  @type t :: %Banzai.Aws.MessageBody{
          configuration_item: String.t(),
          configuration_item_diff: String.t(),
          message_type: String.t(),
          notification_creation_time: String.t(),
          record_version: String.t()
        }
  defstruct configuration_item: nil,
            configuration_item_diff: nil,
            message_type: nil,
            notification_creation_time: nil,
            record_version: nil
end
