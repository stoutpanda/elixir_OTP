defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [ parse_args: 1 ]
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

  end
