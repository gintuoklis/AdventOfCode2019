defmodule SecureContainer do
  @moduledoc """
  Documentation for `SecureContainer`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SecureContainer.hello()
      :world

  """
  def checkIncreaseCondition?(input) do
    digits = Integer.digits(input)
    digits === (Enum.sort(digits))
  end

  def checkTwoIndeticalDigits?(input) do
    count = input |> Integer.digits |> Enum.dedup |> Enum.count
    count !== 6
  end 

  def passwordValid?(input) do
    checkIncreaseCondition?(input) && checkTwoIndeticalDigits?(input)
  end

  def calcValidPasswords(range) do
    Enum.reduce(range, 0, fn i, acc -> if passwordValid?(i) do acc + 1 else acc end end)
  end

  def passwordValidPartB?(input) do
    checkIncreaseCondition?(input) && checkTwoIndeticalDigitsPartB?(input)
  end

  def checkTwoIndeticalDigitsPartB?(input) do
    Integer.digits(input) |> Enum.frequencies |> Map.values |> Enum.any?(fn x -> x==2 end)
  end 

  def calcValidPasswordsPartB(range) do
    Enum.reduce(range, 0, fn i, acc -> if passwordValidPartB?(i) do acc + 1 else acc end end)
  end
end
