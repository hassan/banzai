defmodule Banzai.Aws.Convert do
  @moduledoc """
  Recursively turn camelCase string keys into snake_case atoms.
  """

  def ed(collection) when is_map(collection) do
    collection
    |> Enum.map(fn x -> {parameterize(elem(x, 0)), expand(elem(x, 1))} end)
  end

  def convert(collection) when is_map(collection) do
    for {key, val} <- collection, into: %{}, do: {parameterize(key), expand(val)}
  end

  def convert(collection) when is_list(collection) and length(collection) < 2 do
    collection
    |> List.flatten()
  end

  # def convert(collection) when is_list(collection) do
  #   "list with many things"
  # end

  defp parameterize(atom) when is_atom(atom) do
    atom
    |> Atom.to_string()
    |> Macro.underscore()
    |> String.to_atom()
  end

  defp parameterize(string) when is_binary(string) do
    string
    |> Macro.underscore()
    |> String.to_atom()
  end

  defp expand(val) when is_nil(val) do
    val
  end

  defp expand(val) when is_boolean(val) do
    val
  end

  defp expand(val) when is_number(val) do
    val
  end

  defp expand(val) when is_binary(val) do
    val
  end

  defp expand(val) when is_map(val) do
    convert(val)
  end

  defp expand(val) when is_list(val) and length(val) == 0 do
    val
  end

  defp expand(val) when is_list(val) do
    case list_type(val) do
      {true, _, _, _} -> val
      {_, true, _, _} -> Enum.map(val, fn x -> ed(x) end)
      {_, _, true, _} -> ["LIST OF #{Enum.count(val)} ITEMS"]
      {_, _, _, true} -> "TUPLINESS"
      _ -> it_could_be_anything(val)
    end
  end

  defp it_could_be_anything(_val) do
    "WHATEVER"
  end

  defp list_type(val) do
    {Enum.all?(val, fn x -> is_binary(x) end), Enum.all?(val, fn x -> is_map(x) end),
     Enum.all?(val, fn x -> is_list(x) end), Enum.all?(val, fn x -> is_tuple(x) end)}
  end
end
