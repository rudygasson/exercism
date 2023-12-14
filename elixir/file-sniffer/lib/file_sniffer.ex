defmodule FileSniffer do
  @file_types [
    {"exe", "application/octet-stream", <<0x7F, 0x45, 0x4C, 0x46>>},
    {"bmp", "image/bmp", <<0x42, 0x4D>>},
    {"png", "image/png", <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>},
    {"jpg", "image/jpg", <<0xFF, 0xD8, 0xFF>>},
    {"gif", "image/gif", <<0x47, 0x49, 0x46>>}
  ]

  def type_from_extension(extension) do
    Enum.into(@file_types, %{}, &extension_map/1)[extension]
  end

  def type_from_binary(file_binary) do
    Enum.find(@file_types, &check_signature(file_binary, elem(&1, 2)))
    |> case do
      {_, type, _} -> type
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    type = type_from_extension(extension)

    cond do
      type && type == type_from_binary(file_binary) -> {:ok, type}
      true -> {:error, "Warning, file format and file extension do not match."}
    end
  end

  defp extension_map({extension, media_type, _}), do: {extension, media_type}
  defp type({_, media_type, _}), do: media_type

  defp check_signature(file_binary, signature) do
    case file_binary do
      <<head::binary-size(byte_size(signature)), _::binary>> -> head == signature
      _ -> false
    end
  end

  defp get_media_type(signature) do
    @file_types
    |> Map.new(fn {_, media_type, signature} -> {signature, media_type} end)
    |> Map.get(signature)
  end


end
