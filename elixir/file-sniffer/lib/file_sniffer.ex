defmodule FileSniffer do
  @file_types [
    {"exe", "application/octet-stream", <<0x7F, 0x45, 0x4C, 0x46>>},
    {"bmp", "image/bmp", <<0x42, 0x4D>>},
    {"png", "image/png", <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>>},
    {"jpg", "image/jpg", <<0xFF, 0xD8, 0xFF>>},
    {"gif", "image/gif", <<0x47, 0x49, 0x46>>}
  ]
  @mismatch_message "Warning, file format and file extension do not match."

  def type_from_extension(extension) do
    Enum.into(@file_types, %{}, fn {ext, type, _} -> {ext, type} end)[extension]
  end

  def type_from_binary(file_binary) do
    case Enum.find(@file_types, &check_signature(file_binary, elem(&1, 2))) do
      {_, type, _} -> type
      _ -> nil
    end
  end

  def verify(file_binary, extension) do
    type = type_from_extension(extension)
    cond do
      type && type == type_from_binary(file_binary) -> {:ok, type}
      true -> {:error, @mismatch_message}
    end
  end

  defp check_signature(file_binary, signature) do
    case file_binary do
      <<head::binary-size(byte_size(signature)), _::binary>> -> head == signature
      _ -> false
    end
  end
end
