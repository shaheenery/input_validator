defmodule Validator do
  
  def is_valid?(str) do
    proper_chars?(str) && proper_nesting?(str)
  end

  def proper_chars?(str) do
    Regex.match?(~r/^[\w|\d|\(|\)|\[|\]]+$/, str)
  end

  # we initially receive the string
  def proper_nesting?(str), do: proper_nesting?(String.split(str, ""), [])

  # the base case no chars left and no unclosed ('s or ['s
  def proper_nesting?([], []), do: true

  # end of input and we have unclosed nesting chars
  def proper_nesting?([], _opened), do: false
   
  # we have an opening char in these, recurse with the char added to the list of opened  
  def proper_nesting?([ "("|rest ], opened), do: proper_nesting?(rest, [ "(" | opened ] )
  def proper_nesting?([ "["|rest ], opened), do: proper_nesting?(rest, [ "[" | opened ] )

  # we encounter a closing char and there is nothing open
  def proper_nesting?([ ")" | _rest ], []), do: false
  def proper_nesting?([ "]" | _rest ], []), do: false

  # we encounter a closing char, either close it or return false
  def proper_nesting?([ ")" | rest ], [first|opened]) do
    if "(" == first, do: proper_nesting?(rest, opened), else: false
  end

  def proper_nesting?([ "]" | rest ], [first|opened]) do
    if "[" == first, do: proper_nesting?(rest, opened), else: false
  end

  # we have an a-Z0-9 char here steady as she goes
  def proper_nesting?([_|rest], opened ), do: proper_nesting?(rest, opened)

end