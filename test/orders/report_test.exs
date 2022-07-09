defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "create/1" do
    test "creates report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("report_test.csv")

      result = File.read!("report_test.csv")

      assert result ==
               "123456789,pizza,1,49.99,pizza,1,49.99,99.98\n123456789,pizza,1,49.99,pizza,1,49.99,99.98\n"
    end
  end
end
