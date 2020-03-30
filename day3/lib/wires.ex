defmodule Wires do
  # general idea for part A is the following. convert all instruction to vector points
  # loop through all vector combinations and check if there is inersection
  # if intersection is found calculate the distance to the center point (0,0)
  # continue until you find all intersection points, and pick and find smallest distance

  def parseFile(filePath) do
    {:ok, content} = File.read(filePath)

    array =
      content
      |> String.trim_trailing()
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, ",") end)

    processInstructions(Enum.at(array, 0), Enum.at(array, 1))
  end

  def processInstructions(instructions1, instructions2) do
    vectors1 = convertInstructionsToCoordinates(instructions1) |> convertInstructionsToVektors
    vectors2 = convertInstructionsToCoordinates(instructions2) |> convertInstructionsToVektors

    # IO.inspect(vectors1)
    # IO.inspect(vectors2)
    loopAllVectors(vectors1, vectors2)
  end

  def convertInstructionsToCoordinates(instructions) do
    # first elemetn is zero point {0,0}
    # adding to the end of the acc (not the most efficient thing)
    instructions
    |> Enum.reduce([{0, 0}], fn instruction, acc ->
      acc ++ [convertInstructionsToCoordinates(instruction, List.last(acc))]
    end)
  end

  def convertInstructionsToCoordinates("R" <> number, {x, y}) do
    # only x axis changes
    {x + String.to_integer(number), y}
  end

  def convertInstructionsToCoordinates("L" <> number, {x, y}) do
    # only x axis changes
    {x - String.to_integer(number), y}
  end

  def convertInstructionsToCoordinates("U" <> number, {x, y}) do
    # only y axis changes
    {x, y + String.to_integer(number)}
  end

  def convertInstructionsToCoordinates("D" <> number, {x, y}) do
    # only y axis changes
    {x, y - String.to_integer(number)}
  end

  def convertInstructionsToVektors(coordinates) do
    # zipping list of coordinates with the same list withouth first point (0,0)
    Enum.zip(coordinates, Enum.drop(coordinates, 1))
  end

  def loopAllVectors(vectors1, vectors2) do
    vectors1
    |> Enum.reduce(999_999, fn x, acc -> checkForInteresction(x, vectors2) |> min(acc) end)
  end

  def checkForInteresction(vector, vectors) do
    {{x1, y1}, {x2, y2}} = vector

    vectors
    |> Enum.reduce(999_999, fn {{x3, y3}, {x4, y4}}, acc ->
      findIntersection({x1, y1}, {x2, y2}, {x3, y3}, {x4, y4}) |> findDistance |> min(acc)
    end)
  end

  def findIntersection({x1, y1}, {x2, y2}, {x3, y3}, {x4, y4}) do
    # https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
    # line intersection for finite vectors
    if (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4) != 0 do
      t =
        ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) /
          ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4))

      u =
        -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) /
          ((x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4))

      findIntersection(t, u, {x1, y1}, {x2, y2}, {x3, y3}, {x4, y4})
    else
      {:error, "intersection not found"}
    end
  end

  def findIntersection(t, u, {x1, y1}, {x2, y2}, {x3, y3}, {x4, y4})
      when t <= 1 and t >= 0 and u <= 1 and u >= 0 do
    {:ok, {x1 + t * (x2 - x1), y1 + t * (y2 - y1)}}
  end

  def findIntersection(_, _, _, _, _, _) do
    # in all other cases intersection not found
    {:error, "intersection not found"}
  end

  def findDistance({:error, _}) do
  end

  def findDistance({:ok, {0.0, 0.0}}) do
  end

  def findDistance({:ok, {x, y}}) do
    manhattanDistance({0, 0}, {x, y})
  end

  def manhattanDistance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  # general idea for part B is the following. 
  # first, do it for the set vector1
  # use the same mechnanizsm of finding intersection points but keep step counter (usign the same manhatten)

  # the, do the same for the vector2 set
  # find least distance based on finding from vector1 & vector2 

  def findAllIntersectionPoints(vectors1, vectors2) do
    vectors1
    |> Enum.reduce([], fn {point1, point2}, acc ->
      intersections = checkForInteresctionPartB({point1, point2}, vectors2)

      total_sum =
        Enum.reduce(acc, 0, fn {intersection, _, _, x, _}, acc ->
          if not intersection do
            x + acc
          else
            acc
          end
        end)

      acc = acc ++ [{false, point1, point2, Wires.manhattanDistance(point1, point2), total_sum}]

      case intersections do
        _ ->
          intersections
          |> Enum.reduce(acc, fn intersectionPoint, acc ->
            newlist =
              acc ++
                [
                  {true, point1, intersectionPoint,
                   Wires.manhattanDistance(point1, intersectionPoint), total_sum}
                ]
          end)
      end
    end)
  end

  def checkForInteresctionPartB(vector, vectors) do
    {{x1, y1}, {x2, y2}} = vector

    vectors
    |> Enum.reduce([], fn {{x3, y3}, {x4, y4}}, acc ->
      intersection = findIntersection({x1, y1}, {x2, y2}, {x3, y3}, {x4, y4})

      case intersection do
        {:ok, {0.0, 0.0}} -> acc
        {:ok, {x, y}} -> [{x, y}] ++ acc
        _ -> acc
      end
    end)
  end

  def calcWalkedDistance(vectors) do
    Enum.map(vectors, fn {point1, point2} ->
      Wires.manhattanDistance(point1, point2)
    end)
  end

  def getLastDistance(x) do
    prev = List.last(x)

    if prev != nil do
      {_, _, _, lastDistance} = prev
      lastDistance
    else
      lastDistance = 0
    end
  end

  def getLastPoint(x) do
    prev = List.last(x)

    if prev != nil do
      {_, _, lastPoint, _} = prev
      lastPoint
    else
      lastDistance = {0, 0}
    end
  end

  def findMostOptimalIntersectionPointDistance(vectors1, vectors2) do
    allPointsForVector1 = findAllIntersectionPoints(vectors1, vectors2)
    allPointsForVector2 = findAllIntersectionPoints(vectors2, vectors1)

    intersectionsForVector1 =
      Enum.flat_map(allPointsForVector1, fn {status, _, intersection_point, distance,
                                             total_distance} ->
        if status == true do
          [{intersection_point, total_distance + distance}]
        else
          []
        end
      end)

    intersectionsForVector2 =
      Enum.flat_map(allPointsForVector2, fn {status, _, intersection_point, distance,
                                             total_distance} ->
        if status == true do
          [{intersection_point, total_distance + distance}]
        else
          []
        end
      end)

    Enum.concat(intersectionsForVector2, intersectionsForVector1)
    |> Enum.group_by(fn {x, _} -> x end, fn {_, y} -> y end)
    |> Map.values()
    |> Enum.map(fn x -> Enum.sum(x) end)
    |> Enum.min()
  end

  def parseFileForPartB(filePath) do
    {:ok, content} = File.read(filePath)

    array =
      content
      |> String.trim_trailing()
      |> String.split("\n")
      |> Enum.map(fn x -> String.split(x, ",") end)

    vectors1 = convertInstructionsToCoordinates(Enum.at(array, 0)) |> convertInstructionsToVektors
    vectors2 = convertInstructionsToCoordinates(Enum.at(array, 1)) |> convertInstructionsToVektors

    findMostOptimalIntersectionPointDistance(vectors1, vectors2)
  end
end
