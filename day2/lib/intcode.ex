defmodule Intcode do
  @moduledoc """
  Documentation for `Intcode`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Intcode.hello()
      :world

  """
  def parseFile(filePath) do
     {:ok, content} = File.read(filePath)
     list = content |> String.trim |> String.split(",") |> Enum.map(fn x -> String.to_integer(x) end)

     
  end

  def findsolution() do
    parseFile("input.txt")|>setParamsForProgram(12,2) |> processProgram |>Enum.at(0)
  end

  def findsolutionPart2(program,result,param1,param2) when result == 19690720 do
    100*param1+param2
  end
  
  def findsolutionPart2(program,_,_,_) do
    param1 = Enum.random(0..99)
    param2 = Enum.random(0..99)
    result = program |> setParamsForProgram(param1,param2) |> processProgram |>Enum.at(0)
    findsolutionPart2(program,result,param1,param2)
  end

  def findsolutionPart2() do
    originalProgram = parseFile("input.txt")
    findsolutionPart2(originalProgram,0,0,0)
  end

  def setParamsForProgram(program,param1,param2) do
     program = List.replace_at(program,1,param1)
     List.replace_at(program,2,param2)
  end

  def processProgram(program) do
    processProgram(program,0)
  end

  
  def processProgram(program,pos) do
    opcode = Enum.at(program,pos)
    processProgram(program,pos,opcode)
  end

  def processProgram(program,pos,1) do
    writeToPosition = Enum.at(program,pos+3)
    value1 = Enum.at(program, Enum.at(program,pos+1))
    value2 = Enum.at(program, Enum.at(program,pos+2))
  
    newProgram = List.replace_at(program, writeToPosition, value1 + value2)
    processProgram(newProgram,pos+4) 
  end

  def processProgram(program,pos,2) do
    writeToPosition = Enum.at(program,pos+3)
    value1 = Enum.at(program, Enum.at(program,pos+1))
    value2 = Enum.at(program, Enum.at(program,pos+2))
   
    newProgram = List.replace_at(program, writeToPosition, value1 * value2)
    processProgram(newProgram,pos+4)
  end

  def processProgram(program,pos,99) do
    program
  end
end
