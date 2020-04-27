defmodule ExMonoWrapper.DataCleaner do
  def clean_info(body) do
    body
    |> Enum.map(fn map ->
      Enum.map(map, fn {k, v} -> {transform_key(k), v} end)
      |> Map.new()
    end)
  end

  def clean_client_info(body) do
    account_info =
      body["accounts"]
      |> Enum.map(fn map ->
        Enum.map(map, fn {k, v} -> {String.to_atom(k), v} end) |> Map.new()
      end)

    body
    |> Enum.map(fn {k, v} -> {String.to_atom(k), v} end)
    |> Map.new()
    |> Map.put(:accounts, account_info)
  end

  defp transform_key(k) do
    String.downcase(k) |> String.to_atom()
  end
end
