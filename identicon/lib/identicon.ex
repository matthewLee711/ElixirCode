defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def build_grid(image) do
    
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # Update image struct - create + add rgb
    %Identicon.Image{image | color: {r, g, b}}
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    # Pass back + return image struct
    %Identicon.Image{hex: hex}
  end
end
