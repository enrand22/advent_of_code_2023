defmodule Day2 do

  def task1 do
    input()
    |> Enum.map(&(process_line/1))
    # |> Enum.map(&sum_values/1)
    # |> Enum.filter(fn {_id, %{"red" => red, "blue" => blue, "green" => green}} -> red <= 12 && green <= 13 && blue <= 14 end )

    |> Enum.filter(fn {_id, game} -> Enum.all?(matching_color(game))  end )
    |> Enum.map(fn {id, _} -> id end)
    |> Enum.sum()
  end

  def matching_color(game) do

    Enum.flat_map(game, fn sets -> Enum.map(sets, fn set ->
      case set do
        {"blue", blue} -> blue <= 14
        {"red", red} -> red <= 12
        {"green", green} -> green <= 13
      end
    end) end)

  end

  def sum_values(game) do
    { game_id , sets} = game

    colors = %{"red" => 0, "blue" => 0, "green" => 0}

    colors = sets
    |> Enum.map_reduce(colors, fn {color, value}, colors -> {value , elem(Map.get_and_update(colors, color, fn old_value  ->  {old_value, old_value + value} end), 1) }  end)

    {game_id, elem(colors, 1)}
  end

  def process_line(line) do
    game_id = get_game_id(line)
    {game_id, extract_value(line) }
  end

  def extract_value(line) do
    line
    |> String.trim()
    |> String.split(":")
    |> tl()
    |> Enum.at(0)
    |> String.split(";")
    |> Enum.map(&prepare_set/1)
  end

  def prepare_set(set) do
    set
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&transform_to_tuple/1)
  end

  def transform_to_tuple(color) do
    event = color
            |> String.split(" ")

    {Enum.at(event, 1), parse_int(Enum.at(event, 0))}
  end

  def parse_int(v) do
    Integer.parse(v)
    |> Kernel.elem(0)
  end

  def get_game_id(line) do
    line
    |> String.split(":")
    |> hd()
    |> String.split(" ")
    |> Enum.at(1)
    |> parse_int()
  end

  def input do
    File.stream!("../inputs/day2.txt")
  end

end
