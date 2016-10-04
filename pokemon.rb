require 'pg'
require_relative 'oop_allpokemon'

class Pokemon
  def initialize
  end

  def run_create_pokemon
    @pokemon = Pokemon.new
    @conn = PG.connect(database: 'pokemon')
    @pokemon.ask_pokemon_info
  end
  def ask_pokemon_info
    puts "Please enter the name of your pokemon: "
    @name = gets.chomp
    puts "Please enter your pokemon's type: "
    @monster_type = gets.chomp
    puts "Please enter your pokemon's second type. If it has none, type 'none'."
    @second_type = gets.chomp
    create_pokemon
    puts "The pokemon, #{@name}, has been added with the primary type, #{@monster_type}, and the secondary type, #{@second_type}."
  end
  def create_pokemon
    @conn.exec('INSERT INTO generation2 (name, type, second)' \
      "SELECT '#{name}', '#{monster_type}', '#{second_type}'" \
      'WHERE NOT EXISTS (' \
        'SELECT id FROM generation2 ' \
        "WHERE name = '#{@name}' AND type = '#{@monster_type}' AND second = '#{@second_type}'" \
      ');')
  end

  def run_sort_pokemon
    @pokemon = Pokemon.new
    @conn = PG.connect(database: 'pokemon')
    @pokemon.prompt_user
  end
  def prompt_user
    puts "Please enter 1 to sort by ID number."
    puts "Please enter 2 to sort alphabetically by name."
    puts "Please enter 3 to sort alphabetically by type."
    puts "Please enter 4 to sort alphabetically by second type."
    select_sort
  end
  def select_sort
    sort = get_user_selection
    loop do
      if sort == 1
        sort_by_id
        break
      elsif sort == 2
        sort_by_name
        break
      elsif sort == 3
        sort_by_type
        break
      elsif sort == 4
        sort_by_second_type
        break
      else
        puts "Please enter a valid number (1-4) to select sorting: "
        choice = get_user_selection
      end
    end
  end

  def load_by_id
    @conn.exec('SELECT * FROM generation2 ORDER BY id ASC')
  end
  def sort_by_id
    @generation2 = load_by_id
    display_pokemon
  end

  def load_by_name
    @conn.exec('SELECT * FROM generation2 ORDER BY name ASC')
  end
  def sort_by_name
    @generation2 = load_by_name
    display_pokemon
  end

  def load_by_type
    @conn.exec('SELECT * FROM generation2 ORDER BY type ASC')
  end
  def sort_by_type
    @generation2 = load_by_type
    display_pokemon
  end

  def load_by_second_type
    @conn.exec('SELECT * FROM generation2 ORDER BY second ASC')
  end
  def sort_by_second_type
    @generation2 = load_by_second_type
    display_pokemon
  end

  def display_pokemon
    @generation2.each do |pokemon|
      puts "id: #{pokemon['id']} | " \
        "name: #{pokemon['name']} | " \
        "type: #{pokemon['type']} |" \
        "second type: #{pokemon['second']} |"
    end
    puts "Pokedex database retrieved for Generation 2."
  end

  def run_search_pokemon
    @pokemon = Pokemon.new
    @conn = PG.connect(database: 'pokemon')
    @pokemon.search_pokemon
  end
  def search_pokemon
    puts "Please enter the name of the pokemon you are searching for: "
    @search = gets.chomp
    return_pokemon
  end
  def return_pokemon
    generation2 = load_by_id
    generation2.each do |pokemon|
      if @search ==  "#{pokemon['name']}"
        puts "id: #{pokemon['id']} | " \
        "name: #{pokemon['name']} | " \
        "type: #{pokemon['monster_type']} |" \
        "second type: #{pokemon['second_type']} |"
        puts "Found pokemon."
      end
    end
    @pokemon.select_update_delete
  end

  def select_update_delete
    puts "Please enter 1 to update a pokemon."
    puts "Please enter 2 to delete this pokemon. (WARNING: instant data purge)"

    choice = get_user_selection
    loop do
      if choice == 1
        acquire_update_info
        break
      elsif choice == 2
        delete_pokemon
        break
      else
        puts "Please enter 1 or 2 to update/delete a pokemon: "
        choice = get_user_selection
      end
    end
  end
  def acquire_update_info
    puts "Please update the name of your pokemon: "
    @name = gets.chomp
    puts "Please update your pokemon's type: "
    @monster_type = gets.chomp
    puts "Please update your pokemon's second type. If it has none, type 'none'."
    @second_type = gets.chomp
    update_info
  end
  def update_info
    @conn.exec("UPDATE generation2 SET name = '#{@name}', type = '#{@monster_type}', second = '#{@second_type}' WHERE name = '#{@search}'")
    puts "The pokemon, #{@name}, has been added with the primary type, #{@monster_type}, and the secondary type, #{@second_type}."
    puts "Your pokemon has been updated."
  end

  def delete_pokemon
    @conn.exec("DELETE FROM generation2 WHERE name = '#{search}'")
    puts "Your pokemon has been deleted."
  end

end
