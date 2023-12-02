defmodule Day1 do

  def read_input do
    File.stream!("input.txt")
    |> Enum.map(&(proccess_line/1))
    |> Enum.sum()
  end

  def proccess_line(line) do
    list = line
    |> String.trim()
    |> String.replace(~r/[^\d]/, "")
    |> String.graphemes()

    [Enum.take(list, 1), Enum.take(list, -1)]
    |> Enum.flat_map(fn x -> x end)
    |> Enum.map(&parse_int/1)
    |> Enum.sum()
  end

  def parse_int(v) do
    Integer.parse(v)
    |> Kernel.elem(0)
  end
end
