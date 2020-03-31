defmodule OribitMap do
  @moduledoc """
  Documentation for `OribitMap`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> OribitMap.hello()
      :world

  """
  def findSolution(filePath) do
    {:ok, content} = File.read(filePath)
    orbitalMap = content |> String.trim |> String.split("\n") |> Enum.reduce(%{}, 
    
        fn x, orbits -> 
          [parent, node] = String.split(x,")") 
          
          orbits = orbits |> Map.put_new(parent, "") |> Map.put(node, parent)
        end)
    
        
    orbitalMap |> Map.keys |> Enum.reduce(0, 
      fn x, acc -> 
        numberOfOrbits = calcNumberofOrbits(orbitalMap, x) 
        acc = acc + numberOfOrbits
      end)
 end

 def calcNumberofOrbits(orbitsMap, "", steps) do
  steps
 end

 def calcNumberofOrbits(orbitsMap, target) do
  new_target = orbitsMap |> Map.get(target)
  calcNumberofOrbits(orbitsMap, new_target, 0)  # starting calculating only here
 end
 
 def calcNumberofOrbits(orbitsMap, target, steps) do
  new_target = orbitsMap |> Map.get(target)
  calcNumberofOrbits(orbitsMap, new_target, steps + 1)
 end

 def findSolutionPartB(filePath) do
  {:ok, content} = File.read(filePath)
  orbitalMap = content |> String.trim |> String.split("\n") |> Enum.reduce(%{}, 
  
      fn x, orbits -> 
        [parent, node] = String.split(x,")") 
        
        orbits = orbits |> Map.put_new(parent, "") |> Map.put(node, parent)
      end)
      
    #finding complete path to root node, from both sides.  
    pathforYOU = orbitalMap |> findPathToRoot("YOU")
    pathforSAN = orbitalMap |> findPathToRoot("SAN")
      

    #finding number of step from sides unitl commmon ancesstor
    Enum.count(pathforYOU -- pathforSAN) + Enum.count(pathforSAN -- pathforYOU)

  end

  def findPathToRoot(orbitsMap, "", path) do
    path
   end

  def findPathToRoot(orbitsMap, target) do
    new_target = orbitsMap |> Map.get(target)
    findPathToRoot(orbitsMap, new_target, [] ++ [new_target])
  end

  def findPathToRoot(orbitsMap, target, path) do
    new_target = orbitsMap |> Map.get(target)
    findPathToRoot(orbitsMap, new_target, path ++ [new_target])
   end
end
