defmodule Banzai.Aws do
  @moduledoc """
  The Aws context.
  """

  import Ecto.Query, warn: false
  require Logger
  alias Banzai.Repo
  alias Banzai.Aws.Notification
  alias Banzai.Aws.SubscriptionConfirmation

  @doc """
  Creates a notification.

  ## Examples

      iex> create_notification(%{field: value})
      {:ok, %Notification{}}

      iex> create_notification(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_notification(attrs \\ %{}) do
    notification =
      %Notification{}
      |> Notification.changeset(convert(attrs))
      |> Repo.insert!()

    {:ok, notification}
  end

  def create_subscription_confirmation(attrs \\ %{}) do
    subscription_confirmation =
      %SubscriptionConfirmation{}
      |> SubscriptionConfirmation.changeset(convert(attrs))
      |> Repo.insert!()

    {:ok, subscription_confirmation}
  end

  def convert(notification) do
    for {key, val} <- notification, into: %{}, do: {parameterize(key), val}
  end

  defp parameterize(string) when is_binary(string) do
    string
    |> Macro.underscore()
    |> String.to_atom()
  end

  defp parameterize(atom) when is_atom(atom) do
    atom
    |> Atom.to_string()
    |> Macro.underscore()
    |> String.to_atom()
  end

  def stash_raw_notification(param_string) when is_binary(param_string) do
    Logger.info(fn -> "UNRECOGNIZED: #{param_string}" end)
  end
end
