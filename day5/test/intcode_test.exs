defmodule IntcodeTest do
  use ExUnit.Case

  test "processProgram 1" do
    assert Intcode.processProgram([3,0,4,0,99]) ==  [1, 0, 4, 0, 99]
  end

  # test "processProgram 2" do
  #   assert Intcode.processProgram([2,3,0,3,99]) == [2,3,0,6,99]
  # end

  # test "processProgram 3" do
  #   assert Intcode.processProgram([2,4,4,5,99,0]) == [2,4,4,5,99,9801]
  # end

  # test "processProgram 4" do
  #   assert Intcode.processProgram([1,1,1,4,99,5,6,0,99]) == [30,1,1,4,2,5,6,0,99]
  # end

  #test "findsolution for part 1" do
  #  assert Intcode.findsolution == 8017076
  #end

  #test "findsolution for part 2" do
  #  assert Intcode.findsolutionPart2 == 3146
  #end

  # test "test parseParams" do
  #   assert Intcode.parseParams(1002) == {2, 0, 1, 0}
  # end
  
  test "findsolution for part 1" do
    assert Intcode.findsolution == 8017076
  end
  
end
