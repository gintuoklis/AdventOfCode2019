defmodule FuelCounter do
  @moduledoc """
  Documentation for `FuelCounter`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FuelCounter.hello()
      :world

  """
  def hello do
    :world
  end


  def processfile(filepath) do
    stream = File.stream!(filepath)
    stream |> Enum.map_reduce(0, fn x, acc -> {coverttointeger(x)|>calcFuelNeed, (coverttointeger(x)|>calcFuelNeed)  + acc} end)
  end

  def coverttointeger(input) do
    input |>String.trim |> String.to_integer
  end
  
  def calcFuelNeed(mass) do
      (Float.floor(mass/3,0) - 2) |> max(0)   
  end

  def calcFuelNeedRecursive(mass) when mass <= 0 do
    0
  end

  def calcFuelNeedRecursive(mass) do
    fuelNeed = calcFuelNeed(mass)
    fuelNeed + calcFuelNeedRecursive(fuelNeed)      
  end

  def processfileWithRecursive(filepath) do
    stream = File.stream!(filepath)
    stream |> Enum.map_reduce(0, fn x, acc -> {coverttointeger(x)|>calcFuelNeedRecursive, (coverttointeger(x)|>calcFuelNeedRecursive)  + acc} end)
  end

end