defmodule Exlivery.Users.CreateOrUpdate do
  alias Exlivery.Users.User
  alias Exlivery.Users.Agent, as: UserAgent

  def call(%{name: name, cpf: cpf, age: age, email: email, address: address}) do
    name
    |> User.build(email, cpf, age, address)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}) do
    UserAgent.save(user)
    {:ok, "User created or updated successfully"}
  end

  defp save_user({:error, _} = error), do: error
end
