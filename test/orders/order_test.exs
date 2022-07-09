defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "returns order when all parameters are valid" do
      user = build(:user)
      items = build_list(2, :item)

      response = Order.build(user, items)

      expected = {:ok, build(:order)}

      assert response == expected
    end

    test "returns error no items are provided" do
      user = build(:user)

      response = Order.build(user, [])

      expected = {:error, "Invalid parameters"}

      assert response == expected
    end
  end
end
