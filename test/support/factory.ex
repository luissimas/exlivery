defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      address: "test address",
      age: 20,
      cpf: "123456789",
      email: "test@test.com",
      name: "Test user"
    }
  end

  def item_factory do
    %Item{
      description: "Test item",
      category: :pizza,
      quantity: 1,
      unit_price: Decimal.new("49.99")
    }
  end

  def order_factory do
    user = build(:user)

    %Order{
      delivery_address: user.address,
      items: build_list(2, :item),
      total_price: Decimal.new("99.98"),
      user_cpf: user.cpf
    }
  end
end
