# Identicon

Generates a 300px x 300px image with a 5 x 5 grid of squares. Each is 50px x 50px. The image is horizontally symmetrical.

String -> compute MD5 hash of string -> list numbers based on string -> pick color -> build grid of squares -> convert grid into image -> save image


[1]   [2]   [3]   [2]   [1]
[4]   [5]   [6]   [5]   [4]
[7]   [8]   [9]   [8]   [7]
[10]  [11]  [12]  [11]  [10]
[13]  [14]  [15]  [14]  [13]

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `identicon` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:identicon, "~> 0.1.0"}]
    end
    ```

  2. Ensure `identicon` is started before your application:

    ```elixir
    def application do
      [applications: [:identicon]]
    end
    ```
