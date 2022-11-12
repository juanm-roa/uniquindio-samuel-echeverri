defmodule ChallengeOne do
  @moduledoc """
  In this module rest the necessary functions to solve the Shadow Sum problem
  """

  @spec iterate(t :: integer) :: %{integer => integer}
  def iterate(t), do: iterate(1, t, %{})

  @spec iterate(count :: integer, t :: integer, results :: %{integer => integer}) :: %{integer => integer}
  defp iterate(_count, 0, _results), do: IO.puts("")
  defp iterate(count, t, results) when count > t, do: results
  defp iterate(count, t, results) when count <= t do
    # n is the array size for the test case
    n = IO.gets("")
        |> String.trim
        |> String.to_integer
    filtered_list = filter_numbers( get_list(n) )
    iterate( count+1, t, Map.put( results, count, Enum.sum(filtered_list) ) )
  end

  @spec get_list(n :: integer) :: [integer]
  defp get_list(n) do
    list = IO.gets("")
           |> String.split
           |> Enum.map(fn x -> String.to_integer(x) end)

    case length(list) do
      ^n -> list
      _ -> IO.puts("Wrong number of elements for the array. Please enter #{n} elements")
           get_list(n)
    end
  end

  @spec filter_numbers([integer]) :: [integer]
  defp filter_numbers([head | tail]) do
    case not Enum.member?(tail, head) && not Enum.member?(tail, head*(-1)) do
      true -> filter_numbers(tail, [head])
      _    -> filter_numbers(tail)
    end
  end

  @spec filter_numbers([integer], [integer]) :: [integer]
  defp filter_numbers([], filtered), do: filtered
  defp filter_numbers([head | tail], filtered) do
    case not Enum.member?(tail, head) && not Enum.member?(tail, head*(-1)) do
      true -> filter_numbers(tail, [head | filtered])
      _    -> filter_numbers(tail, filtered)
    end
  end

  @spec show_results(count :: integer, cases :: integer, results :: %{integer => integer}) :: :ok
  def show_results(count, cases, results) when count == cases, do: IO.puts("Case #{count}: #{Map.get(results, count)}")
  def show_results(count, cases, results) do
    IO.puts("Case #{count}: #{Map.get(results, count)}")
    show_results(count+1, cases, results)
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
