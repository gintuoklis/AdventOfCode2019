defmodule OribitMapTest do
  use ExUnit.Case
  
  
  

  test "find number of orbits" do
    assert OribitMap.calcNumberofOrbits(%{"B" => "COM", "C" => "B", "COM" => "", "D" => "C", "E" => "D", "F" => "E", "G" => "B", "H" => "G", "I" => "D", "J" => "E", "K" => "J", "L" => "K"}, "D") ==3
  end

  test "find number of orbits on root" do
    assert OribitMap.calcNumberofOrbits(%{"B" => "COM", "C" => "B", "COM" => "", "D" => "C", "E" => "D", "F" => "E", "G" => "B", "H" => "G", "I" => "D", "J" => "E", "K" => "J", "L" => "K"}, "COM") ==0
  end

  test "find number of orbits last node" do
    assert OribitMap.calcNumberofOrbits(%{"B" => "COM", "C" => "B", "COM" => "", "D" => "C", "E" => "D", "F" => "E", "G" => "B", "H" => "G", "I" => "D", "J" => "E", "K" => "J", "L" => "K"}, "L") ==7
  end

  test "findsolution for example 1" do
    assert OribitMap.findSolution("small_input.txt") == 42
  end

  test "findsolution for part 1" do
    assert OribitMap.findSolution("input.txt") == 249308
  end

  test "findsolution for part B test data" do
    assert OribitMap.findSolutionPartB("small_inputPartB.txt") == 4 
  end

  test "findsolution for part B" do
    assert OribitMap.findSolutionPartB("input.txt") == 349 
  end

  test "find path to root YOU" do 
    assert OribitMap.findPathToRoot(%{"B" => "COM", "C" => "B", "COM" => "", "D" => "C", "E" => "D", "F" => "E", "G" => "B", "H" => "G", "I" => "D", "J" => "E", "K" => "J", "L" => "K", "SAN" => "I", "YOU" => "K"}, "YOU") == ["K", "J", "E", "D", "C", "B", "COM", ""]
  end

  test "find path to root SAN " do 
    assert OribitMap.findPathToRoot(%{"B" => "COM", "C" => "B", "COM" => "", "D" => "C", "E" => "D", "F" => "E", "G" => "B", "H" => "G", "I" => "D", "J" => "E", "K" => "J", "L" => "K", "SAN" => "I", "YOU" => "K"}, "SAN") == ["I", "D", "C", "B", "COM", ""]
  end


end
