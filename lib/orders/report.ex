defmodule Exlivery.Orders.Report do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Order
  alias Exlivery.Orders.Item

  def create(filename \\ "report.csv") do
    order_list = build_order_list()

    File.write(filename, order_list)
  end

  defp build_order_list() do
    OrderAgent.list()
    |> Map.values()
    |> Enum.map(&stringify_order/1)
  end

  defp stringify_order(%Order{user_cpf: cpf, items: items, total_price: total_price}) do
    items_string = Enum.map(items, &stringify_item/1)

    "#{cpf},#{items_string}#{total_price}\n"
  end

  defp stringify_item(%Item{category: category, quantity: quantity, unit_price: unit_price}) do
    "#{category},#{quantity},#{unit_price},"
  end
end
