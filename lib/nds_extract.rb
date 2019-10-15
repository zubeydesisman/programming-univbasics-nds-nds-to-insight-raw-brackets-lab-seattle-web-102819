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
#   i = 0 
#   while i< nds.length do 
#     key = nds[i][:name] 
    
#     j = 0 
#     movie_data = nds[i][:movies]
#     value = 0
#     while j < movie_data.length do
#       value += movie_data[j][:worldwide_gross]
#       j += 1
#     end
#     i += 1
#     result[key] = value
#   end
#   return result
# end
  for name_movies in nds do
   value = 0
    key = name_movies[:name]
    movie_array = name_movies[:movies]
    for movie in movie_array do
     value += movie[:worldwide_gross]
    end
    result[key] = value
  end
  return result
end
  