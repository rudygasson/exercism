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

  defp do_encode([last], enc_dna), do: <<enc_dna::bitstring, encode_nucleotide(last)::4>>
  defp do_encode([head | tail], enc_dna) do
    acc = <<enc_dna::bitstring, encode_nucleotide(head)::4>>
    do_encode(tail, acc)
  end

  def decode(dna), do: do_decode(dna, [])

  defp do_decode(<<last::4>>, dec_dna), do: dec_dna ++ [decode_nucleotide(last)]
  defp do_decode(<<head::4, tail::bitstring>>, dec_dna) do
    dec_dna = dec_dna ++ [decode_nucleotide(head)]
    do_decode(tail, dec_dna)
  end
end
