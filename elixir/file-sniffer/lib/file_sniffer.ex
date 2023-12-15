defmodule FileSniffer do
  @file_types %{
    exe: "application/octet-stream",
    bmp: "image/bmp",
    png: "image/png",
    jpg: "image/jpg",
    gif: "image/gif"
  }

  @signatures %{
    <<0x7F, 0x45, 0x4C, 0x46>> => :exe,
    <<0x42, 0x4D>> => :bmp,
    <<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A>> => :png,
    <<0xFF, 0xD8, 0xFF>> => :jpg,
    <<0x47, 0x49, 0x46>> => :gif
  }

  @mismatch_message "Warning, file format and file extension do not match."

  def type_from_extension(extension) do
    @file_types[String.to_atom(extension)]
  end

  def type_from_binary(file_binary) do
    signature = Map.keys(@signatures)
    |> Enum.find(&(check_signature(file_binary, &1)))
    @file_types[@signatures[signature]]
  end

  def verify(file_binary, extension) do
    case {type_from_extension(extension), type_from_binary(file_binary)} do
      {type, type} when type != nil -> {:ok, type}
      _ -> {:error, @mismatch_message}
    end
  end

  defp check_signature(file_binary, signature) do
    case file_binary do
      <<head::binary-size(byte_size(signature)), _::binary>> -> head == signature
      _ -> false
    end
  end
end
