defmodule WiresTest do
  use ExUnit.Case

  test "test conversion of instructions1" do
    assert Wires.convertInstructionsToCoordinates([
             "R75",
             "D30",
             "R83",
             "U83",
             "L12",
             "D49",
             "R71",
             "U7",
             "L72"
           ]) == [
             {0, 0},
             {75, 0},
             {75, -30},
             {158, -30},
             {158, 53},
             {146, 53},
             {146, 4},
             {217, 4},
             {217, 11},
             {145, 11}
           ]
  end

  test "test conversion of instructions2" do
    assert Wires.convertInstructionsToCoordinates([
             "U62",
             "R66",
             "U55",
             "R34",
             "D71",
             "R55",
             "D58",
             "R83"
           ]) == [
             {0, 0},
             {0, 62},
             {66, 62},
             {66, 117},
             {100, 117},
             {100, 46},
             {155, 46},
             {155, -12},
             {238, -12}
           ]
  end

  test "test conversion to vektors" do
    assert Wires.convertInstructionsToVektors([
             {0, 0},
             {75, 0},
             {75, -30},
             {158, -30},
             {158, 53},
             {146, 53},
             {146, 4},
             {217, 4},
             {217, 11},
             {145, 11}
           ]) ==
             [
               {{0, 0}, {75, 0}},
               {{75, 0}, {75, -30}},
               {{75, -30}, {158, -30}},
               {{158, -30}, {158, 53}},
               {{158, 53}, {146, 53}},
               {{146, 53}, {146, 4}},
               {{146, 4}, {217, 4}},
               {{217, 4}, {217, 11}},
               {{217, 11}, {145, 11}}
             ]
  end

  test "find intersection point between two vectors" do
    assert Wires.findIntersection({0, 0}, {0, 6}, {-2, 3}, {2, 3}) == {:ok, {0, 3}}
  end

  test "test imposible interesection between two non-intersecting vectors" do
    {:error, _} = assert Wires.findIntersection({0, 0}, {0, 6}, {-2, 7}, {2, 7})
  end

  test "test imposible interesection between two non-intersecting vectors2" do
    {:error, _} = assert Wires.findIntersection({0, 0}, {75, 0}, {66, 62}, {66, 117})
  end

  test "find distances for first small exmaple" do
    assert Wires.processInstructions(
             [
               "R8",
               "U5",
               "L5",
               "D3"
             ],
             [
               "U7",
               "R6",
               "D4",
               "L4"
             ]
           ) == 6
  end

  test "find distances for first exmple3  " do
    assert Wires.processInstructions(
             [
               "R75",
               "D30",
               "R83",
               "U83",
               "L12",
               "D49",
               "R71",
               "U7",
               "L72"
             ],
             [
               "U62",
               "R66",
               "U55",
               "R34",
               "D71",
               "R55",
               "D58",
               "R83"
             ]
           ) == 159
  end

  test "find distances for first exmple2" do
    assert Wires.processInstructions(
             ["R98", "U47", "R26", "D63", "R33", "U87", "L62", "D20", "R33", "U53", "R51"],
             ["U98", "R91", "D20", "R16", "D67", "R40", "U7", "R15", "U6", "R7"]
           ) == 135
  end

  test "test manhatten distance 1" do
    assert Wires.manhattanDistance({0, 0}, {75, 0}) == 75
  end

  test "test manhatten distance 2" do
    assert Wires.manhattanDistance({75, 0}, {75, -30}) == 30
  end

  test "findAllIntersectionPoints" do
    assert Wires.findAllIntersectionPoints(
             [
               {{0, 0}, {75, 0}},
               {{75, 0}, {75, -30}},
               {{75, -30}, {158, -30}},
               {{158, -30}, {158, 53}},
               {{158, 53}, {146, 53}},
               {{146, 53}, {146, 4}},
               {{146, 4}, {217, 4}},
               {{217, 4}, {217, 11}},
               {{217, 11}, {145, 11}}
             ],
             [
               {{0, 0}, {0, 62}},
               {{0, 62}, {66, 62}},
               {{66, 62}, {66, 117}},
               {{66, 117}, {100, 117}},
               {{100, 117}, {100, 46}},
               {{100, 46}, {155, 46}},
               {{155, 46}, {155, -12}},
               {{155, -12}, {238, -12}}
             ]
           ) == [{158.0, -12.0}, {146.0, 46.0}, {155.0, 4.0}, {155.0, 11.0}]
  end

  test "calculate walked path" do
    assert Wires.calcWalkedDistance([
             {{0, 0}, {75, 0}},
             {{75, 0}, {75, -30}},
             {{75, -30}, {158, -30}},
             {{158, -30}, {158, 53}},
             {{158, 53}, {146, 53}},
             {{146, 53}, {146, 4}},
             {{146, 4}, {217, 4}},
             {{217, 4}, {217, 11}},
             {{217, 11}, {145, 11}}
           ]) == [75, 30, 83, 83, 12, 49, 71, 7, 72]
  end

  test "findAllIntersectionPoints2" do
    assert Wires.findAllIntersectionPoints(
             [{{0, 0}, {8, 0}}, {{8, 0}, {8, 5}}, {{8, 5}, {3, 5}}, {{3, 5}, {3, 2}}],
             [{{0, 0}, {0, 7}}, {{0, 7}, {6, 7}}, {{6, 7}, {6, 3}}, {{6, 3}, {2, 3}}]
           ) == [
             {{0, 0}, {8, 0}, 8},
             {{8, 0}, {8, 5}, 13},
             {{8, 5}, {6.0, 5.0}, 15.0},
             {{6.0, 5.0}, {3, 5}, 18.0},
             {{3, 5}, {3.0, 3.0}, 20.0},
             {{3.0, 3.0}, {3, 2}, 21.0}
           ]
  end

  test "findAllIntersectionPoints3" do
    assert Wires.findAllIntersectionPoints(
             [{{0, 0}, {0, 7}}, {{0, 7}, {6, 7}}, {{6, 7}, {6, 3}}, {{6, 3}, {2, 3}}],
             [{{0, 0}, {8, 0}}, {{8, 0}, {8, 5}}, {{8, 5}, {3, 5}}, {{3, 5}, {3, 2}}]
           ) == [
             {{0, 0}, {0, 7}, 7},
             {{0, 7}, {6, 7}, 13},
             {{6, 7}, {6.0, 5.0}, 15.0},
             {{6.0, 5.0}, {6, 3}, 17.0},
             {{6, 3}, {3.0, 3.0}, 20.0},
             {{3.0, 3.0}, {2, 3}, 21.0}
           ]
  end

  test "calculate walked path2" do
    assert Wires.calcWalkedDistance([
             {{0, 0}, {8, 0}},
             {{8, 0}, {8, 5}},
             {{8, 5}, {3, 5}},
             {{3, 5}, {3, 2}}
           ]) == [8, 5, 5, 3]
  end

  test "calculate walked path3" do
    assert Wires.calcWalkedDistance([
             {{0, 0}, {0, 7}},
             {{0, 7}, {6, 7}},
             {{6, 7}, {6, 3}},
             {{6, 3}, {2, 3}}
           ]) == [7, 6, 4, 4]
  end

  test "findMostOptimalIntersectionPoint" do
    assert Wires.findMostOptimalIntersectionPointDistance(
             [{{0, 0}, {0, 7}}, {{0, 7}, {6, 7}}, {{6, 7}, {6, 3}}, {{6, 3}, {2, 3}}],
             [{{0, 0}, {8, 0}}, {{8, 0}, {8, 5}}, {{8, 5}, {3, 5}}, {{3, 5}, {3, 2}}]
           ) == 30
  end

  test "findMostOptimalIntersectionPoint2" do
    assert Wires.findMostOptimalIntersectionPointDistance(
             [
               {{0, 0}, {75, 0}},
               {{75, 0}, {75, -30}},
               {{75, -30}, {158, -30}},
               {{158, -30}, {158, 53}},
               {{158, 53}, {146, 53}},
               {{146, 53}, {146, 4}},
               {{146, 4}, {217, 4}},
               {{217, 4}, {217, 11}},
               {{217, 11}, {145, 11}}
             ],
             [
               {{0, 0}, {0, 62}},
               {{0, 62}, {66, 62}},
               {{66, 62}, {66, 117}},
               {{66, 117}, {100, 117}},
               {{100, 117}, {100, 46}},
               {{100, 46}, {155, 46}},
               {{155, 46}, {155, -12}},
               {{155, -12}, {238, -12}}
             ]
           ) == 610
  end

  test "findMostOptimalIntersectionPoint3" do
    assert Wires.findMostOptimalIntersectionPointDistance(
             [
               {{0, 0}, {98, 0}},
               {{98, 0}, {98, 47}},
               {{98, 47}, {124, 47}},
               {{124, 47}, {124, -16}},
               {{124, -16}, {157, -16}},
               {{157, -16}, {157, 71}},
               {{157, 71}, {95, 71}},
               {{95, 71}, {95, 51}},
               {{95, 51}, {128, 51}},
               {{128, 51}, {128, 104}},
               {{128, 104}, {179, 104}}
             ],
             [
               {{0, 0}, {0, 98}},
               {{0, 98}, {91, 98}},
               {{91, 98}, {91, 78}},
               {{91, 78}, {107, 78}},
               {{107, 78}, {107, 11}},
               {{107, 11}, {147, 11}},
               {{147, 11}, {147, 18}},
               {{147, 18}, {162, 18}},
               {{162, 18}, {162, 24}},
               {{162, 24}, {169, 24}}
             ]
           ) == 410
  end
end
