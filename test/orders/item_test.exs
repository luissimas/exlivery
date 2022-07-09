defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "returns item when all params are valid" do
      response = Item.build("Test item", :pizza, "49.99", 1)

      expected = {:ok, build(:item)}

      assert response == expected
    end

    test "returns error when invalid category" do
      response = Item.build("Test item", :any_category, "49.99", 1)

      expected = {:error, "Invalid parameters"}

      assert response == expected
    end

    test "returns error when invalid quantity" do
      response = Item.build("Test item", :pizza, "49.99", 0)

      expected = {:error, "Invalid parameters"}

      assert response == expected
    end

    test "returns error when invalid unit_price" do
      response = Item.build("Test item", :pizza, "any_price", 1)

      expected = {:error, "Invalid price"}

      assert response == expected
    end
  end
end
