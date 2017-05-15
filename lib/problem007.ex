defmodule Problem007 do
  @moduledoc """
  Project Euler, Problem 7

  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
  that the 6th prime is 13.

  What is the 10 001st prime number?

  ## Notes

  Now, this is interesting. The overview suggests that "if a good upper bound
  for the target prime is known in advance, using a sieve of Eratosthenes is a
  much more efficient method." What I do not know is this: if we have to *build*
  the sieve as we go along, is it STILL more efficient?

  Then they proceed to give a less efficient mechanism for determining if a
  given number is prime, which essentially does trial division of every 4th and
  6th number up to sqrt(n). (We can skip evens because n/2, and because n/3, the
  other two "threes" are 6k+1 or 6k-1. So they start at 5 and go upwards testing
  rem(n,k)==0 and rem(n,k+2)==0, then k+=6. This is much less efficient than a
  sieve but it is neat that this mechanism does not require memory to store the
  sieve. It simply counts each prime number as it finds it and then moves on.

  I strongly suspect the sieve to be more efficient in this case as well, since
  we have to find ALL of the first 10,001 primes, but if we had to find, say,
  the FIRST prime number above 1 billion... well, then I suspect the method
  given here is better.
  """

  @doc """
  Solve problem 7.
  """
  def solve! do
    nth_prime 10_001
  end

  @doc """
  Returns the nth prime.

  ## Examples:

  iex> Problem007.nth_prime(1)
  2

  iex> Problem007.nth_prime(6)
  13
  """
  def nth_prime(n), do: nth_prime(next_prime(), n-1)
  def nth_prime(primes, 0), do: hd(primes)
    def nth_prime(primes, num_to_go) do
    nth_prime(next_prime(primes), num_to_go-1)
  end

  # RESEARCH: next_prime stolen unmodified from problem003.ex; I really should
  # learn how to share code and require it and stuff
  @doc """
  Given a list of primes, return the list with the next highest prime added. If
  the list is missing or empty, returns 2

  ## Examples:

      iex> Problem007.next_prime([5, 3, 2])
      [7, 5, 3, 2]

      iex> Problem007.next_prime([])
      [2]

      iex> Problem007.next_prime()
      [2]

      iex> Problem007.next_prime([7, 5, 3, 2])
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
