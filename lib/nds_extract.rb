$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'directors_database'

def directors_totals(nds)
  pp nds
  # Remember, it's always OK to pretty print what you get *in* to make sure
  # that you know what you're starting with!
  #
  #
  # The Hash result be full of things like "Jean-Pierre Jeunet" => "222312123123"
  result = {
  }
  i = 0 
  while i< nds.length do 
    key = nds[i][:name] 
    
    j = 0 
    movie_data = nds[i][:movies]
    value = 0
    while j < movie_data.length do
      value += movie_data[j][:worldwide_gross]
      j += 1
    end
    i += 1
    result[key] = value
  end
  #
  # Use loops, variables and the accessing method, [], to loop through the NDS
  # and total up all the
  # ...
  # ...
  # ...
  #
  #
  # Be sure to return the result at the end!
  #nil
  return result
end
