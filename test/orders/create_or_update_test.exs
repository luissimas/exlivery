defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      cpf = "44411199981"

      user = build(:user, cpf: cpf)

      Exlivery.start_agents()

      UserAgent.save(user)

      item1 = %{
        category: :pizza,
        description: "Sample pizza",
        quantity: 1,
        unit_price: 49.99
      }

      item2 = %{
        category: :sobremesa,
        description: "Sample sobremesa",
        quantity: 1,
        unit_price: 9.99
      }

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "saves a new order when all params are valid", %{
      user_cpf: user_cpf,
      item1: item1,
      item2: item2
    } do
      params = %{user_cpf: user_cpf, items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "returns error when user is not found", %{item1: item1, item2: item2} do
      params = %{user_cpf: "a", items: [item1, item2]}

      response = CreateOrUpdate.call(params)

      assert response == {:error, "User not found"}
    end

    test "returns error when item is invalid", %{user_cpf: user_cpf, item1: item1, item2: item2} do
      params = %{user_cpf: user_cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreateOrUpdate.call(params)

      assert response == {:error, "Invalid items"}
    end

    test "returns error when there are no items", %{user_cpf: user_cpf} do
      params = %{user_cpf: user_cpf, items: []}

      response = CreateOrUpdate.call(params)

      assert response == {:error, "Invalid parameters"}
    end
  end
end
