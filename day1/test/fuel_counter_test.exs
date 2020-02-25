defmodule FuelCounterTest do
  use ExUnit.Case
  doctest FuelCounter

  test "calcFuelNeed for 12" do
    assert FuelCounter.calcFuelNeed(12) == 2
  end

  
  test "calcFuelNeed for 14" do
    assert FuelCounter.calcFuelNeed(14) == 2
  end

  
  test "calcFuelNeed for 1969" do
    assert FuelCounter.calcFuelNeed(1969) == 654
  end

  
  test "calcFuelNeed for 100756" do
    assert FuelCounter.calcFuelNeed(100756) == 33583
  end

  test "calcFuelNeed for entire file" do
    {_, 3231195.0} = assert FuelCounter.processfile("input.txt") 
  end  

  test "recursive fuel counter 14" do
    assert FuelCounter.calcFuelNeedRecursive(14) == 2
  end
  
  test "recursive fuel counter 1969" do
    assert FuelCounter.calcFuelNeedRecursive(1969) == 966
  end  

  test "recursive fuel counter 100756" do
    assert FuelCounter.calcFuelNeedRecursive(100756) == 50346
  end  
end
