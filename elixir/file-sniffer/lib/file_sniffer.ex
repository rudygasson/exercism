defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(file_binary) do
    case file_binary do
      <<0x7F, _::binary-size(3), _::binary>> -> "application/octet-stream"
      <<0x42, _::binary-size(1), _::binary>> -> "image/bmp"
      <<0x89, _::binary-size(7), _::binary>> -> "image/png"
      <<0xFF, _::binary-size(2), _::binary>> -> "image/jpg"
      <<0x47, _::binary-size(2), _::binary>> -> "image/gif"
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
end
