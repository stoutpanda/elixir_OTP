defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1,
                            sort_into_ascending_order: 1 ]

    test ":help returned by option parsing with -h and --help options" do
      assert parse_args(["-h",     "anything"]) == :help
      assert parse_args(["--help", "anything"]) == :help
    end

    test "three values returned by parse_args if 3 values given" do
      assert parse_args(["user", "project", "22"]) == { "user","project",22 }
    end

    test "@default_count is used if only 2 values are given" do
      assert parse_args(["user", "project"]) == { "user", "project", 4 }
    end

    test "sort ascending orders the correct way" do
      result = sort_into_ascending_order(fake_created_at_list(["c","a","b"]))
      issues = for issue <- result, do: Map.get(issue, "created_at")
      assert issues == ~w{a b c}
    end

    defp fake_created_at_list(values) do
      for value <- values,
      do: %{"created_at" => value, "other_data" => "xxx"} 
    end

  end
