defmodule Problem006 do
  @moduledoc """
  Project Euler, Problem 6

  The sum of the squares of the first ten natural numbers is,

  1**2 + 2**2 + ... + 10**2 = 385

  The square of the sum of the first ten natural numbers is,

  (1 + 2 + ... + 10)**2 = 552 = 3025

  Hence the difference between the sum of the squares of the first ten natural
  numbers and the square of the sum is 3025 − 385 = 2640.

  Find the difference between the sum of the squares of the first one hundred
  natural numbers and the square of the sum.
"""

  def solve! do
    square_of_sums_minus_sum_of_squares 1..100
  end

  @doc """
  The naiive solution here seems pretty obvious and straightfoward:

  (1..10).map {|x| x**2}.sum - (1..10).sum ** 2

  We'll keep it for now, because this kind of map manipulation is exactly what I
  need to learn in Elixir right now. However, looking at the problem overview
  document, there is indeed a problem with this algorithm as n becomes
  large. TL;DR we already know that instead of Enum.sum(1..n), we can simply
  calculate n(n+1)/2. It turns out there's a similar formula for sums of
  squares, and it is

  (2n+1)(n+1)n/6

  Also note that I've written my method to take a list and am passing in a range
  of 1..n, but the problem (and the shortcut show above) limit the problem
  definition to JUST the natural numbers from 1 to n, not an arbitrary list.

  ## Examples:

      iex> Problem006.square_of_sums_minus_sum_of_squares(1..10)
      2640
  """
  def square_of_sums_minus_sum_of_squares(list) do
    (:math.pow(Enum.sum(list), 2) |> Float.floor |> round) - (Enum.map(list, fn(x) -> x*x end) |> Enum.sum)
  end

  @doc """
  Sample method to demonstrate doctest boilerplate

  ## Examples:

      iex> Problem006.add(2, 3)
      5
  """
  def add(a, b) do
    a + b
  end
end
