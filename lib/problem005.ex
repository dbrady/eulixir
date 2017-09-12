defmodule Problem005 do
  @moduledoc """
  Project Euler, Problem 005.

  2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

  What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

  Did you know Euler publishes "Discussion" papers about solving the
  problems??? Holy cow these are amazing.

  https://projecteuler.net/overview=005
  """
  def solve! do
    least_common_multiple_of_all_integers_up_to 20
  end

  @doc """
  Return least common multiple of integers 1..n.

  ## Examples:

      iex> Problem005.least_common_multiple_of_all_integers_up_to 4
      12

      iex> Problem005.least_common_multiple_of_all_integers_up_to 5
      60

      iex> Problem005.least_common_multiple_of_all_integers_up_to 6
      60

      iex> Problem005.least_common_multiple_of_all_integers_up_to 10
      2520
  """
  def least_common_multiple_of_all_integers_up_to(n) do
    primes_up_to(n) |>
      Enum.map(fn(p) -> perfect_power_under(p, n) end) |>
      Enum.reduce(fn(x, acc) -> x * acc end)
  end

  @doc """
  Return list of primes up to (and possible including) n.

  ## Examples:

      iex> Problem005.primes_up_to 10
      [7, 5, 3, 2]

      iex> Problem005.primes_up_to 20
      [19, 17, 13, 11, 7, 5, 3, 2]

      iex> Problem005.primes_up_to 1
      []

      iex> Problem005.primes_up_to 7
      [7, 5, 3, 2]

      iex> Problem005.primes_up_to 2
      [2]
  """
  def primes_up_to(n), do: primes_up_to(n, [])
  def primes_up_to(n, []), do: primes_up_to(n, [2])
  def primes_up_to(n, primes) do
    if hd(primes) <= n do
      primes_up_to(n, next_prime(primes))
    else
      tl(primes)
    end
  end

  @doc """
  Return largest integer power under a bound.

  Examples:

  iex> Problem005.perfect_power_under(2, 20)
  16

  iex> Problem005.perfect_power_under(5, 200)
  125

  iex> Problem005.perfect_power_under(2, 64)
  64
  """
  def perfect_power_under(base, bound) do
    :math.log(bound) / :math.log(base)
    |> Float.floor
    |> round
    |> (&(:math.pow(base, &1))).() # pipe into 2nd arg
    |> round
  end

  # RESEARCH: next_prime stolen unmodified from problem003.ex; I really should
  # learn how to share code and require it and stuff
  @doc """
  Given a list of primes, return the list with the next highest prime added. If
  the list is missing or empty, returns 2

  ## Examples:

  iex> Problem005.next_prime([5, 3, 2])
  [7, 5, 3, 2]

  iex> Problem005.next_prime([])
  [2]

  iex> Problem005.next_prime()
  [2]

  iex> Problem005.next_prime([7, 5, 3, 2])
  [11, 7, 5, 3, 2]
  """
  def next_prime, do: [2]
  def next_prime([]), do: [2]
  def next_prime([2]), do: [3, 2]
  def next_prime(primes), do: next_prime(primes, hd(primes)+2)
  def next_prime(primes, candidate) do
    if Enum.any?(primes, fn(p) -> rem(candidate, p) == 0 end) do
      # not prime; next candidate
      next_prime(primes, candidate+2)
    else
      [candidate | primes]
    end
  end
end

# RESEARCH: when I grow up I want to know how to do elapsed time
# 2017-05-14 - Probably want to investigate timer.tc
IO.puts Time.utc_now
IO.puts Problem005.solve!
IO.puts Time.utc_now
