require_relative 'oop_allpokemon'
require 'pg'
require_relative 'pokemon.rb'

def select_search
  puts "Please enter the number of the function you would like to perform: "
  puts "(1) Create a pokemon."
  puts "(2) Read pokemon list."
  puts "(3) Search pokemon to update / delete."

  selection = get_user_selection

  loop do
    if selection == 1
      run_create_pokemon
      break
    elsif selection == 2
      run_sort_pokemon
      break
    elsif selection == 3
      run_search_pokemon
      break
    else
      puts "Please enter a valid option (1-3): "
      selection = get_user_selection
    end
  end
end
def get_user_selection
  gets.chomp.to_i
end

def main
  conn = PG.connect(dbname: 'pokemon')
  startup(conn)
  select_search
end

main if __FILE__ == $PROGRAM_NAME
