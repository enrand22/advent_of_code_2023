defmodule Day1 do

  def task1 do
    File.stream!("input.txt")
    |> Enum.map(&(proccess_line/1))
    |> Enum.sum()
  end

  def task2 do
    File.stream!("input.txt")
    |> Enum.map(&(replace_spelt_numbers/1))
    |> Enum.map(&(proccess_line/1))
    |> Enum.sum()
  end

  def replace_spelt_numbers("one" <> rest), do: "1" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("two" <> rest), do: "2" <> replace_spelt_numbers("o" <> rest)
  def replace_spelt_numbers("three" <> rest), do: "3" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("four" <> rest), do: "4" <> replace_spelt_numbers("r" <> rest)
  def replace_spelt_numbers("five" <> rest), do: "5" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers("six" <> rest), do: "6" <> replace_spelt_numbers("x" <> rest)
  def replace_spelt_numbers("seven" <> rest), do: "7" <> replace_spelt_numbers("n" <> rest)
  def replace_spelt_numbers("eight" <> rest), do: "8" <> replace_spelt_numbers("t" <> rest)
  def replace_spelt_numbers("nine" <> rest), do: "9" <> replace_spelt_numbers("e" <> rest)
  def replace_spelt_numbers(<<char, rest::binary>>), do: <<char>> <> replace_spelt_numbers(rest)
  def replace_spelt_numbers(""), do: ""

  def proccess_line(line) do
    list = line
    |> String.trim()
    |> String.replace(~r/[^\d]/, "")
    |> String.graphemes()

    [Enum.take(list, 1), Enum.take(list, -1)]
    |> Enum.flat_map(fn x -> x end)
    |> Enum.join("")
    |> parse_int()
  end

  def parse_int(v) do
    Integer.parse(v)
    |> Kernel.elem(0)
  end
end
