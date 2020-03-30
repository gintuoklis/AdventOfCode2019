defmodule SecureContainerTest do
  use ExUnit.Case


  test "checkIncreaseCondition1" do
    assert SecureContainer.checkIncreaseCondition?(123456) == :true
  end

  test "checkIncreaseCondition2" do
    assert SecureContainer.checkIncreaseCondition?(123465) == :false
  end


  test "checkTwoIndeticalDigits1" do
    assert SecureContainer.checkTwoIndeticalDigits?(122345) == :true
  end

  test "checkTwoIndeticalDigits2" do
    assert SecureContainer.checkTwoIndeticalDigits?(123456) == :false
  end


  test "passwordValid1" do
    assert SecureContainer.passwordValid?(223450) == :false
  end

  test "passwordValid2" do
    assert SecureContainer.passwordValid?(123789) == :false
  end

  test "passwordValid3" do
    assert SecureContainer.passwordValid?(111111) == :true
  end

  test "passwordValid4" do
    assert SecureContainer.passwordValid?(122345) == :true
  end

  test "calculateValidPassword" do 
    assert SecureContainer.calcValidPasswords(134564..585159) == 1929
  end     

  test "checkTwoIndeticalDigitsPartB1" do
    assert SecureContainer.checkTwoIndeticalDigitsPartB?(112233) == :true
  end

  test "checkTwoIndeticalDigitsPartB2" do
    assert SecureContainer.checkTwoIndeticalDigitsPartB?(123444) == :false
  end
  
  test "checkTwoIndeticalDigitsPartB3" do
    assert SecureContainer.checkTwoIndeticalDigitsPartB?(111122) == :true
  end

  test "calculateValidPasswordPartB" do 
    assert SecureContainer.calcValidPasswordsPartB(134564..585159) == 1306
  end  
end
