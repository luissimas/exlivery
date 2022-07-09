defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  alias Exlivery.Users.Agent, as: UserAgent

  import Exlivery.Factory

  describe "save/1" do
    test "saves a new user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      cpf = "11122233344"

      {:ok, cpf: cpf}
    end

    test "when user is found, returns user", %{cpf: cpf} do
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      assert UserAgent.get(cpf) == {:ok, user}
    end

    test "when user is not found, returns error" do
      assert UserAgent.get("00000000000") == {:error, "User not found"}
    end
  end
end
