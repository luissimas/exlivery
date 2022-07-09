defmodule Exlivery.Orders.AgentTest do
  use ExUnit.Case

  alias Exlivery.Orders.Agent, as: OrderAgent

  import Exlivery.Factory

  describe "save/1" do
    test "saves a new order" do
      order = build(:order)

      OrderAgent.start_link(%{})

      assert {:ok, _uuid} = OrderAgent.save(order)
    end
  end

  describe "get/1" do
    setup do
      OrderAgent.start_link(%{})

      :ok
    end

    test "when order is found, returns order" do
      order = build(:order)
      {:ok, uuid} = OrderAgent.save(order)

      response = OrderAgent.get(uuid)

      assert response == {:ok, order}
    end

    test "when order ir not found, returns error" do
      assert OrderAgent.get("a") == {:error, "Order not found"}
    end
  end
end
