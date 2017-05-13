defmodule Problem002 do
  @moduledoc """
  Project Euler, Problem 2.

    Each new term in the Fibonacci sequence is generated by adding the previous
    two terms. By starting with 1 and 2, the first 10 terms will be:

    1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

    By considering the terms in the Fibonacci sequence whose values do not
    exceed four million, find the sum of the even-valued terms.
  """

  def solve! do
    Problem002.sum_even_fibs 0, 1, 4000000, 0
  end

  @doc """
  Sum all even terms of the Fibonacci sequence below n


  Examples:

  # iex> Problem002.sum_even_fibs 0, 1, 10, 0
  10

  iex> Problem002.sum_even_fibs 0, 1, 100, 0
  44
  """
  def sum_even_fibs(a, b, max, accum) do
    IO.puts "sum_even_fibs(#{a}, #{b}, #{max}, #{accum})"
    if b >= max do
      accum
    else
      new_accum = if rem(b, 2) == 0 do
        accum + b
      else
        accum
      end

      sum_even_fibs(b, a+b, max, new_accum)
    end
  end
end
