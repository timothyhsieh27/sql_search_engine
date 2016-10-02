require_relative 'allpokemon'
require 'pg'

def count_pokemon(conn)
  result = conn.exec('SELECT count(*) FROM generation2')

  result.getvalue(0, 0).to_i
end

def run_create_pokemon(conn)
  ask_pokemon_info(conn)
end
def ask_pokemon_info(conn)
  puts "Please enter the name of your pokemon: "
  name = gets.chomp
  puts "Please enter your pokemon's type: "
  monster_type = gets.chomp
  puts "Please enter your pokemon's second type. If it has none, type 'none'."
  second_type = gets.chomp
  create_pokemon(conn, name, monster_type, second_type)
  puts "The pokemon, #{name}, has been added with the primary type, #{monster_type}, and the secondary type, #{second_type}."
end
def create_pokemon(conn, name, monster_type, second_type)
  sql = 'INSERT INTO generation2 (name, type, second)' \
    "SELECT '#{name}', '#{monster_type}', '#{second_type}'" \
    'WHERE NOT EXISTS (' \
      'SELECT id FROM generation2 ' \
      "WHERE name = '#{name}' AND type = '#{monster_type}' AND second = '#{second_type}'" \
    ');'

  conn.exec(sql)
end

def run_sort_pokemon(conn)
  puts "Please enter 1 to sort by ID number."
  puts "Please enter 2 to sort alphabetically by name."
  puts "Please enter 3 to sort alphabetically by type."
  puts "Please enter 4 to sort alphabetically by second type."
  select_sort(conn)
end
def select_sort(conn)
  sort = get_user_selection
  loop do
    if sort == 1
      sort_by_id(conn)
      break
    elsif sort == 2
      sort_by_name(conn)
      break
    elsif sort == 3
      sort_by_type(conn)
      break
    elsif sort == 4
      sort_by_second_type(conn)
      break
    else
      puts "Please enter a valid number (1-4) to select sorting: "
      choice = get_user_selection
    end
  end
end

def sort_by_id(conn)
  generation2 = load_by_id(conn)
  display_pokemon(generation2)
end
def load_by_id(conn)
  conn.exec('SELECT * FROM generation2 ORDER BY id ASC')
end

def sort_by_name(conn)
  generation2 = load_by_name(conn)
  display_pokemon(generation2)
end
def load_by_name(conn)
  conn.exec('SELECT * FROM generation2 ORDER BY name ASC')
end

def sort_by_type(conn)
  generation2 = load_by_type(conn)
  display_pokemon(generation2)
end
def load_by_type(conn)
  conn.exec('SELECT * FROM generation2 ORDER BY type ASC')
end

def sort_by_second_type(conn)
  generation2 = load_by_second_type(conn)
  display_pokemon(generation2)
end
def load_by_second_type(conn)
  conn.exec('SELECT * FROM generation2 ORDER BY second ASC')
end

def display_pokemon(generation2)
  generation2.each do |pokemon|
    puts "id: #{pokemon['id']} | " \
      "name: #{pokemon['name']} | " \
      "type: #{pokemon['type']} |" \
      "second type: #{pokemon['second']} |"
  end
  puts "Pokedex database retrieved for Generation 2."
end

def run_search_pokemon(conn)
  search_pokemon(conn)
end
def search_pokemon(conn)
  puts "Please enter the name of the pokemon you are searching for: "
  search = gets.chomp
  return_pokemon(conn, search)
end
def return_pokemon(conn, search)
  generation2 = load_by_id(conn)
  generation2.each do |pokemon|
    if search ==  "#{pokemon['name']}"
      puts "id: #{pokemon['id']} | " \
      "name: #{pokemon['name']} | " \
      "type: #{pokemon['monster_type']} |" \
      "second type: #{pokemon['second_type']} |"
      puts "Found pokemon."
    end
  end
  select_update_delete(conn, search)
end
def select_update_delete(conn, search)
  puts "Please enter 1 to update a pokemon."
  puts "Please enter 2 to delete this pokemon. (WARNING: instant data purge)"

  choice = get_user_selection
  loop do
    if choice == 1
      acquire_update_info(conn, search)
      break
    elsif choice == 2
      delete_pokemon(conn, search)
      break
    else
      puts "Please enter 1 or 2 to update/delete a pokemon: "
      choice = get_user_selection
    end
  end
end

def acquire_update_info(conn, search)
  puts "Please update the name of your pokemon: "
  name = gets.chomp
  puts "Please update your pokemon's type: "
  monster_type = gets.chomp
  puts "Please update your pokemon's second type. If it has none, type 'none'."
  second_type = gets.chomp
  update_info(conn, name, monster_type, second_type, search)
end
def update_info(conn, name, monster_type, second_type, search)
  sql = "UPDATE generation2 SET name = '#{name}', type = '#{monster_type}', second = '#{second_type}' WHERE name = '#{search}'";
  conn.exec(sql)
  puts "The pokemon, #{name}, has been added with the primary type, #{monster_type}, and the secondary type, #{second_type}."
  puts "Your pokemon has been updated."
end
def delete_pokemon(conn, search)
  sql = "DELETE FROM generation2 WHERE name = '#{search}'";
  conn.exec(sql)
  puts "Your pokemon has been deleted."
end


def select_search(conn)
  puts "Please enter the number of the function you would like to perform: "
  puts "(1) Create a pokemon."
  puts "(2) Read pokemon list."
  puts "(3) Search pokemon to update / delete."

  selection = get_user_selection

  loop do
    if selection == 1
      run_create_pokemon(conn)
      break
    elsif selection == 2
      run_sort_pokemon(conn)
      break
    elsif selection == 3
      run_search_pokemon(conn)
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
  select_search(conn)
end

main if __FILE__ == $PROGRAM_NAME
