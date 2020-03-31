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
    parseFile("input.txt")|> processProgram 
  end

  def setParamsForProgram(program,param1,param2) do
     program = List.replace_at(program,1,param1)
     List.replace_at(program,2,param2)
  end

  def processProgram(program) do
    processProgram(program,0)
  end

  
  def processProgram(program,pos) do
    {opcode, firstParamMode, secondParamMode, thirdParamMode} = Enum.at(program,pos) |> parseParams
    processProgram(program,pos,opcode,firstParamMode, secondParamMode, thirdParamMode)
  end

  def processProgram(program,pos,1, firstParamMode, secondParamMode, thirdParamMode) do
    writeToPosition =  Enum.at(program,pos+3)

    value1 = getValue(program, firstParamMode, pos+1)
    value2 = getValue(program, secondParamMode, pos+2)
    
    newProgram = List.replace_at(program, writeToPosition, value1 + value2)
    processProgram(newProgram,pos+4) 
  end

  def processProgram(program,pos,2, firstParamMode, secondParamMode, thirdParamMode) do
    writeToPosition = Enum.at(program,pos+3)
    

    value1 = getValue(program, firstParamMode, pos+1)
    value2 = getValue(program, secondParamMode, pos+2)
       
    newProgram = List.replace_at(program, writeToPosition, value1 * value2)
    processProgram(newProgram,pos+4)
  end

  def processProgram(program,pos,3, firstParamMode, secondParamMode, thirdParamMode) do
    writeToPosition =  Enum.at(program,pos+1)
    newProgram = List.replace_at(program, writeToPosition, 5) #harcoding 1, special input, for part B harcoding part 1
    processProgram(newProgram,pos+2)
  end

  def processProgram(program,pos,4, firstParamMode, secondParamMode, thirdParamMode) do
    Enum.at(program, Enum.at(program,pos+1)) |> IO.inspect
    processProgram(program,pos+2)
  end

  def processProgram(program,pos,5, firstParamMode, secondParamMode, thirdParamMode) do
    
    value1 = getValue(program, firstParamMode, pos+1)
    value2 = getValue(program, secondParamMode, pos+2)
    
    if value1 !== 0 do
      processProgram(program,value2)
    else
      processProgram(program,pos+3)  
    end
  end

  def processProgram(program,pos,6, firstParamMode, secondParamMode, thirdParamMode) do
    
    value1 = getValue(program, firstParamMode, pos+1)
    value2 = getValue(program, secondParamMode, pos+2)
    
    if value1 === 0 do
      processProgram(program,value2)
    else
      processProgram(program,pos+3)  
    end
  end

  def processProgram(program,pos,7, firstParamMode, secondParamMode, thirdParamMode) do
    writeToPosition =  Enum.at(program,pos+3)

    value1 = getValue(program, firstParamMode, pos+1)
    value2 = getValue(program, secondParamMode, pos+2)
    
    if value1 < value2 do
      newProgram = List.replace_at(program, writeToPosition, 1) 
      processProgram(newProgram,pos+4)
    else
      newProgram = List.replace_at(program, writeToPosition, 0)   
      processProgram(newProgram,pos+4)
    end
  end

  def processProgram(program,pos,8, firstParamMode, secondParamMode, thirdParamMode) do
    writeToPosition =  Enum.at(program,pos+3)

    value1 = getValue(program, firstParamMode, pos+1)
    value2 = getValue(program, secondParamMode, pos+2)
    
    if value1 == value2 do
      newProgram = List.replace_at(program, writeToPosition, 1) 
      processProgram(newProgram,pos+4)
    else
      newProgram = List.replace_at(program, writeToPosition, 0)   
      processProgram(newProgram,pos+4)
    end
  end

  def processProgram(program,_,99, _, _, _) do
    program
  end

  def parseParams(input) do
    parmString = input |> Integer.to_string |> String.pad_leading(5, "0") 
    opcode = parmString |> String.slice(3,2) |> String.to_integer
    firstParamMode = parmString |> String.at(2) |> String.to_integer
    secondParamMode = parmString |> String.at(1) |> String.to_integer
    thirdParamMode = parmString |> String.at(0) |> String.to_integer
    {opcode, firstParamMode, secondParamMode, thirdParamMode}
  end

  def getValue(program, paramMode, pos) do

    if paramMode == 0 do
      Enum.at(program, Enum.at(program,pos))  
    else
      Enum.at(program,pos)
    end
  end

end
