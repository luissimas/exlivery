defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias Exlivery.Users
  alias Users.Agent, as: UserAgent
  alias Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "saves the user" do
      params = %{
        name: "Sample name",
        cpf: "11122233399",
        age: 20,
        email: "email@email.com",
        address: "Sample address"
      }

      result = CreateOrUpdate.call(params)

      assert result == {:ok, "User created or updated successfully"}
    end

    test "returns error on invalid params" do
      params = %{
        name: "Sample name",
        cpf: "11122233399",
        age: 10,
        email: "email@email.com",
        address: "Sample address"
      }

      result = CreateOrUpdate.call(params)

      assert result == {:error, "Invalid parameters"}
    end
  end
end
