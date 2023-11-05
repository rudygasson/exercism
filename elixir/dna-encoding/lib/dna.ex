defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?\s -> 0
      ?A -> 1
      ?C -> 2
      ?G -> 4
      ?T -> 8
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0 -> ?\s
      1 -> ?A
      2 -> ?C
      4 -> ?G
      8 -> ?T
    end
  end

  def encode(dna), do: do_encode(dna, <<>>)

  defp do_encode([], enc_dna), do: enc_dna
  defp do_encode([head | tail], enc_dna) do
    do_encode(tail, <<enc_dna::bitstring, encode_nucleotide(head)::4>>)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<>>, dec_dna), do: dec_dna
  defp do_decode(<<head::4, tail::bitstring>>, dec_dna) do
    do_decode(tail, dec_dna ++ [decode_nucleotide(head)])
  end
end
