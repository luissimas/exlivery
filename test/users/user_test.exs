defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "returns user when all params are valid" do
      response = User.build("Test user", "test@test.com", "123456789", 20, "test address")

      expected = {:ok, build(:user)}

      assert response == expected
    end

    test "returns error when age > 18" do
      response = User.build("Test user", "test@test.com", "123456789", 17, "test address")

      expected = {:error, "Invalid parameters"}

      assert response == expected
    end
  end
end
