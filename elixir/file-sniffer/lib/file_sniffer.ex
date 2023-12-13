defmodule FileSniffer do
  @file_types [
    {"exe", "application/octet-stream", <<0x7F, 0x45, 0x4C, 0x46>>},
    {"bmp", "image/bmp", <<0x42, 0x4D>>},
    {"png", "image/png", <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>},
    {"jpg", "image/jpg", <<0xFF, 0xD8, 0xFF>>},
    {"gif", "image/gif", <<0x47, 0x49, 0x46>>}
  ]

  def type_from_extension(extension) do
    extension_map()[extension]
  end

  def type_from_binary(file_binary) do
    Enum.find(signature_list(), &check_signature(file_binary, &1))
    |> get_media_type
  end

  def verify(file_binary, extension) do
    type = type_from_extension(extension)

    cond do
      type && type == type_from_binary(file_binary) -> {:ok, type}
      true -> {:error, "Warning, file format and file extension do not match."}
    end
  end

  defp extension_map do
    @file_types
    |> Map.new(fn {extension, media_type, _} -> {extension, media_type} end)
  end

  defp signature_list do
    Enum.map(@file_types, fn {_, _, signature} -> signature end)
  end

  defp get_media_type(signature) do
    @file_types
    |> Map.new(fn {_, media_type, signature} -> {signature, media_type} end)
    |> Map.get(signature)
  end

  defp check_signature(file_binary, signature) do
    case file_binary do
      <<sig::binary-size(byte_size(signature)), _::binary>> -> sig == signature
      _ -> false
    end
  end
end
