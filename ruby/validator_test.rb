require_relative "validator"

require "test/unit"


class TestValidator < Test::Unit::TestCase
 
  def setup
    @validator = Validator.new
  end

  def test_validate
    #valid
    assert @validator.is_valid?("abcd1234")
    
    #invalid chars
    assert !@validator.is_valid?("ab$cd1234")
    assert !@validator.is_valid?("ab^cd1234")
    assert !@validator.is_valid?("ab-cd1234")
    assert !@validator.is_valid?("ab@cd1234")
    

    #valid nesting
    assert @validator.is_valid?("abc()d1234")
    assert @validator.is_valid?("abc(d1)234")
    assert @validator.is_valid?("abc(d1)23()4")
    assert @validator.is_valid?("abc(d1)23()4")
    assert @validator.is_valid?("abc(d1)2[[([])]]3([])4")
    assert @validator.is_valid?("[]")
    assert @validator.is_valid?("()")
    assert @validator.is_valid?("(())")
    assert @validator.is_valid?("((([[]])))")
    assert @validator.is_valid?("[()]([])")

    #invalid nesting
    assert !@validator.is_valid?("([)")
    assert !@validator.is_valid?("(")
    assert !@validator.is_valid?("[")
    assert !@validator.is_valid?(")")
    assert !@validator.is_valid?("]")

  end
 
end
