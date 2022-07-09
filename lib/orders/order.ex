defmodule Exlivery.Orders.Order do
  alias Exlivery.Users.User
  alias Exlivery.Orders.Item

  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: get_total_price(items)
     }}
  end

  def build(_user, _items), do: {:error, "Invalid parameters"}

  defp get_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), fn %{unit_price: price, quantity: quantity}, acc ->
      price
      |> Decimal.mult(quantity)
      |> Decimal.add(acc)
    end)
  end
end
