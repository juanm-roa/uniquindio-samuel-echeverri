defmodule ChallengeOne do
  @moduledoc """
  In this module rest the necessary functions to solve the Shadow Sum problem
  """

  # This is the function to use outside the module. It just calls its recursive "twin" function
  def iterate(t), do: iterate(1, t, %{})

  # If t = 0, there are no test cases to evaluate, so the output will be just ""
  def iterate(_count, 0, _results), do: IO.puts("")

  @doc """
  count:   Counts the iterations made
  t:       Number of test cases
  results: Map where the results will be stored this way:
          {case, result} For example: {{1, 14}, {2, 30}, ...}

  Returns the full results map
  """
  def iterate(count, t, results) when count < t do
    # n is the array size for the test case
    n = IO.gets("")
        |> String.trim
        |> String.to_integer

    # Once we know n, we get the numbers list and filter it to avoid numbers with the same magnitude
    filtered_list = filter_numbers( get_list(n) )

    # Once we get the filtered list, we can calculate its sum and put this result into the results map
    # to continue with the next test case
    iterate( count+1, t, Map.put( results, count, Enum.sum(filtered_list) ) )
  end

  # When the counter (count) reaches the number of test cases (t), iterations end
  def iterate(count, t, results) when count == t do
    n = IO.gets("")
        |> String.trim
        |> String.to_integer

    filtered_list = filter_numbers( get_list(n) )

    # Since this is the last iteration, this just returns the updated results map
    Map.put( results, count, Enum.sum(filtered_list) )
  end

  @doc """
  Returns an integer list with n elements
  """
  def get_list(n) do
    list = IO.gets("")
           |> String.split   # Returns a string list, i.e. ["4", "7", "9"]
           |> Enum.map(fn x -> String.to_integer(x) end) # Returns an integer list given the string list

    # Validation
    if length(list) != n do
      IO.puts("Wrong number of elements for the array. Please enter #{n} elements")
      get_list(n)
    else
      list
    end
  end

  @doc """
  Receives an integer list
  Returns the given list without equal-magnitude elements
  """
  def filter_numbers([head | tail]) do
    if( not Enum.member?(tail, head) && not Enum.member?(tail, head*(-1)) ) do
      filter_numbers(tail, [head])
    else
      filter_numbers(tail)
    end
  end

  defp filter_numbers([], filtered), do: filtered

  defp filter_numbers([head | tail], filtered) do
    if( not Enum.member?(tail, head) && not Enum.member?(tail, head*(-1)) ) do
      filter_numbers(tail, [head | filtered])
    else
      filter_numbers(tail, filtered)
    end
  end

  @doc """
  Prints in console the shadow sum result for each test case (using the given results map)
  """
  def show_results(count, cases, results) when count < cases do
    IO.puts("Case #{count}: #{Map.get(results, count)}")
    show_results(count+1, cases, results)
  end

  def show_results(count, cases, results) when count == cases do
    IO.puts("Case #{count}: #{Map.get(results, count)}")
  end

end

# t is the number of test cases the program will run
t = IO.gets("")
    |> String.trim
    |> String.to_integer

# results is a map that will store the result for each test case
results = ChallengeOne.iterate(t)

# Showing the results
ChallengeOne.show_results(1, t, results)
