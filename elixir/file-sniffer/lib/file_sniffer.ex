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
    if is_binary(file_binary) do
      case Enum.find(@file_types, fn {_, _, signature} ->
             if byte_size(signature) <= byte_size(file_binary) do
               <<sig::binary-size(byte_size(signature)), _::binary>> = file_binary
               sig == signature
             end
           end) do
        {_, media_type, _} -> media_type
        _ -> nil
      end
    else
      nil
    end
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

  defp get_media_type(param) do
    case param do
      _ -> nil
    end
  end
end
