defmodule ValidatorTest do
  use ExUnit.Case
  
  test "valid characters" do
    assert Validator.is_valid?("abcd1234")
  end

  test "invalid characters" do
    refute Validator.is_valid?("ab$cd1234")
    refute Validator.is_valid?("ab^cd1234")
    refute Validator.is_valid?("ab-cd1234")
    refute Validator.is_valid?("ab@cd1234")
  end

  test "valid nesting" do
    assert Validator.is_valid?("abc()d1234")
    assert Validator.is_valid?("abc(d1)234")
    assert Validator.is_valid?("abc(d1)23()4")
    assert Validator.is_valid?("abc(d1)23()4")
    assert Validator.is_valid?("abc(d1)2[[([])]]3([])4")
    assert Validator.is_valid?("[]")
    assert Validator.is_valid?("()")
    assert Validator.is_valid?("(())")
    assert Validator.is_valid?("((([[]])))")
    assert Validator.is_valid?("[()]([])")
  end

  test "invalid nesting" do
    refute Validator.is_valid?("([)")
    refute Validator.is_valid?("(")
    refute Validator.is_valid?("[")
    refute Validator.is_valid?(")")
    refute Validator.is_valid?("]")
  end

end
