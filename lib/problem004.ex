defmodule Problem004 do
  @moduledoc """
  Project Euler, Problem 004.

  A palindromic number reads the same both ways. The largest palindrome made
  from the product of two 2-digit numbers is 9009 = 91 × 99.

  Find the largest palindrome made from the product of two 3-digit numbers.
  """

  def solve! do
    (for i <- 900..999, j <- 900..999, k = i*j, is_palindrome?(k), do: k) |> Enum.max
  end

  def is_palindrome?(n) do
    Integer.to_string(n) == String.reverse(Integer.to_string(n))
  end
end

IO.puts Time.utc_now
IO.puts Problem004.solve!
IO.puts Time.utc_now
