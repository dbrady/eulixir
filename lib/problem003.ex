defmodule Problem003 do
  @moduledoc """
  Project Euler, Problem 003.

  The prime factors of 13195 are 5, 7, 13 and 29.

  What is the largest prime factor of the number 600851475143 ?


  Okay, this is like SUPER EASY you guys! Check it out:

  Enum.max(prime_factors(600851475143))

  BOOM. Just use Enum.max and BAM. Done.

  (Implementation of prime_factors/1 is left as an exercise to the reader.)

  So... yeah. Yikes. Okay, back to some hardcore math fundamentals here. Prime
  factors are all of the integer factors of a number that are prime, so I'm
  gonna need to be able to:

  1. get all the factors of a number (fairly easy)
  2. know if a number is prime (harder, but not impossible)

  ...Wait. Maybe not. Okay, my approach historically has been hardcore OO, using
  the Sieve of Eratosthenes, and sharing around a big ol' bucket of known primes
  for all the integers to use and extend as more primes are found. That entire
  approach may be bunkum here.

  See, here's the thing. I DON'T need to know all the factors of this number. I
  DON'T need to know all the primes up to the square root of this number. I just
  need to know what the largest prime factor is. I could nibble away at the
  number, factoring it down with primes... (this train of thought continues in
  the 2doc for find_largest_prime_factor)


  """

  def solve! do
    find_largest_prime_factor 600851475143
  end



  @doc """
  return the largest prime factor of number

  number is the number to be worked with. We will whittle it down recursively by
  dividing it by prime numbers.

  primes is a List of prime factors discovered so far. Each time a new prime is
  discovered, we'll push it onto the head of primes. Theoretically this leaves
  the tail of primes immutable. When we finally exhaust our search, hd(primes)
  will contain the last, and largest, prime factor.

  Examples:

  iex> Problem003.find_largest_prime_factor(10)
  5

  iex> Problem003.find_largest_prime_factor(17)
  17

  iex> Problem003.find_largest_prime_factor(64)
  2
  """
  def find_largest_prime_factor(number, primes \\ []) do
    # if is_nil(List.first(primes)) do
    #   IO.puts ""
    #   IO.puts "--------------------"
    #   IO.puts "Factoring #{number}..."
    # else
    #   IO.puts "Primes: #{inspect(primes)}"
    # end

    # if primes is not empty and hd(primes) >= number do
    #   # we're done!
    #   return hd(primes)
    # end
    #
    # if number is divisible by any p in primes,
    #   # do nothing with primes
    #   # number = number / p
    #   # recurse
    #   find_largest_prime_factor div(number, p), primes
    # else
    #   # find next largest prime
    #   find_largest_prime_factor number, next_prime(primes)
    # end

    # vvv there's an idiomatic way to call hd(primes) that doesn't crash when
    # primes is [] vvv
    if !is_nil(List.first(primes)) && hd(primes) >= number do
      # IO.puts "Done! Returning #{hd(primes)}"
      hd(primes)
    else
      case Enum.find(primes, fn(p) -> rem(number,p) == 0 end) do
        nil -> find_largest_prime_factor number, next_prime(primes)
        # p -> IO.puts("/#{p}") && find_largest_prime_factor div(number, p), primes
        p -> find_largest_prime_factor div(number, p), primes
      end
    end
  end

  @doc """
  Given a list of primes, return the list with the next highest prime added. If
  the list is missing or empty, returns 2

  ## Examples:

      iex> Problem003.next_prime([5, 3, 2])
      [7, 5, 3, 2]

      iex> Problem003.next_prime([])
      [2]

      iex> Problem003.next_prime()
      [2]

      iex> Problem003.next_prime([7, 5, 3, 2])
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

IO.puts Time.utc_now
IO.puts Problem003.solve!
IO.puts Time.utc_now
