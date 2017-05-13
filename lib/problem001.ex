defmodule Problem001 do
  @moduledoc """
  Project Euler, Problem 1.

  If we list all the natural numbers below 10 that are multiples of 3 or 5, we
  get 3, 5, 6 and 9. The sum of these multiples is 23.

  Find the sum of all the multiples of 3 or 5 below 1000.
  """

  @doc """
  Sum of all the multiples of 3 or 5 below 1000.
  """
  def solve! do
    sum_of_3s_and_5s_up_to 1000
  end

  @doc """
  Return the sum of all integers from 0 to n-1 that are multiples of 3 or 5.

  Examples:

  iex> Problem001.sum_of_3s_and_5s_up_to(10)
  23
  """
  def sum_of_3s_and_5s_up_to(n) do
    Enum.filter(1..n-1, fn x -> rem(x,3) == 0 || rem(x,5) == 0 end) |> Enum.sum
  end
end
