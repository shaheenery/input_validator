class Validator

  def is_valid?(str)

    proper_chars?(str) && proper_nesting?(str)
    
  end

  def proper_chars?(str)
    str.match(/^[\w|\d|\(|\)|\[|\]]+$/) ? true : false
  end

  def proper_nesting?(str, opening = "")
    first_char = str[0]
    rest = str[1..-1]

    if first_char == nil
      opening == "" ? true : false
    elsif first_char == "("
      proper_nesting?(rest, opening + "(")
    elsif first_char == "["
      proper_nesting?(rest, opening +"[")
    elsif first_char == ")"
      if opening[-1] == "(" 
        proper_nesting?(rest, opening[0..-2])
      else
        false
      end
    elsif first_char == "]"
      if opening[-1] == "[" 
        proper_nesting?(rest, opening[0..-2])
      else
        false
      end
    else
      proper_nesting?(rest, opening)
    end
  end


end