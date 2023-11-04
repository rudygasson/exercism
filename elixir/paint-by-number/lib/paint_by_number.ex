defmodule PaintByNumber do
  def palette_bit_size(color_count) when color_count <= 2, do: 1
  def palette_bit_size(color_count) do
    palette_bit_size(color_count/2) + 1
  end

  def empty_picture() do
    <<>>
  end

  def test_picture() do
    <<0::2, 1::2, 2::2, 3::2>>
  end

  def prepend_pixel(picture, color_count, pixel_color_index) do
    color_bits = palette_bit_size(color_count)
    <<pixel_color_index::size(color_bits), picture::bitstring>>
  end

  def get_first_pixel(<<>>, _), do: nil
  def get_first_pixel(picture, color_count) do
    color_bits = palette_bit_size(color_count)
    <<head::size(color_bits), _::bitstring>> = picture
    head
  end

  def drop_first_pixel(<<>>, _), do: <<>>
  def drop_first_pixel(picture, color_count) do
    color_bits = palette_bit_size(color_count)
    <<_::size(color_bits), tail::bitstring>> = picture
    tail
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end
