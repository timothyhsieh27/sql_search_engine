require_relative 'oop_database'

def startup(conn)
  disable_notices(conn)
  create_generation2_table(conn)
  add_all_pokemon(conn)
end
def disable_notices(conn)
  conn.exec('SET client_min_messages TO WARNING;')
end
def create_generation2_table(conn)
  conn.exec(
    'CREATE TABLE IF NOT EXISTS generation2 (' \
    'id SERIAL PRIMARY KEY,' \
    'name VARCHAR,' \
    'type VARCHAR,' \
    'second VARCHAR)'
  )
end
def add_pokemon(conn, name, monster_type, second_type)
  sql = 'INSERT INTO generation2 (name, type, second)' \
    "SELECT '#{name}', '#{monster_type}', '#{second_type}'" \
    'WHERE NOT EXISTS (' \
      'SELECT id FROM generation2 ' \
      "WHERE name = '#{name}' AND type = '#{monster_type}' AND second = '#{second_type}'" \
    ');'

  conn.exec(sql)
end
def add_all_pokemon(conn)
  add_pokemon(conn, 'Chikorita', 'Grass', 'none')
  add_pokemon(conn, 'Bayleef', 'Grass', 'none')
  add_pokemon(conn, 'Meganium', 'Grass', 'none')
  add_pokemon(conn, 'Cyndaquil', 'Fire', 'none')
  add_pokemon(conn, 'Quilava', 'Fire', 'none')
  add_pokemon(conn, 'Typhlosion', 'Fire', 'none')
  add_pokemon(conn, 'Totodile', 'Water', 'none')
  add_pokemon(conn, 'Croconaw', 'Water', 'none')
  add_pokemon(conn, 'Feraligatr', 'Water', 'none')
  add_pokemon(conn, 'Sentret', 'Normal', 'none')
  add_pokemon(conn, 'Furret', 'Normal', 'none')
  add_pokemon(conn, 'Hoothoot', 'Normal', 'Flying')
  add_pokemon(conn, 'Noctowl', 'Normal', 'Flying')
  add_pokemon(conn, 'Ledyba', 'Bug', 'Flying')
  add_pokemon(conn, 'Ledian', 'Bug', 'Flying')
  add_pokemon(conn, 'Spinarak', 'Bug', 'Poison')
  add_pokemon(conn, 'Ariados', 'Bug', 'Poison')
  add_pokemon(conn, 'Crobat', 'Poison', 'Flying')
  add_pokemon(conn, 'Chinchou', 'Water', 'Electric')
  add_pokemon(conn, 'Lanturn', 'Water', 'Electric')
  add_pokemon(conn, 'Pichu', 'Electric', 'none')
  add_pokemon(conn, 'Cleffa', 'Normal', 'none')
  add_pokemon(conn, 'Igglybuff', 'Normal', 'none')
  add_pokemon(conn, 'Togepi', 'Normal', 'none')
  add_pokemon(conn, 'Togetic', 'Normal', 'Flying')
  add_pokemon(conn, 'Natu', 'Psychic', 'Flying')
  add_pokemon(conn, 'Xatu', 'Psychic', 'Flying')
  add_pokemon(conn, 'Mareep', 'Electric', 'none')
  add_pokemon(conn, 'Flaaffy', 'Electric', 'none')
  add_pokemon(conn, 'Ampharos', 'Electric', 'none')
  add_pokemon(conn, 'Bellossom', 'Grass', 'none')
  add_pokemon(conn, 'Marill', 'Water', 'none')
  add_pokemon(conn, 'Azumarill', 'Water', 'none')
  add_pokemon(conn, 'Sudowoodo', 'Rock', 'none')
  add_pokemon(conn, 'Politoed', 'Water', 'none')
  add_pokemon(conn, 'Hoppip', 'Grass', 'Flying')
  add_pokemon(conn, 'Skiploom', 'Grass', 'Flying')
  add_pokemon(conn, 'Jumpluff', 'Grass', 'Flying')
  add_pokemon(conn, 'Aipom', 'Normal', 'none')
  add_pokemon(conn, 'Sunkern', 'Grass', 'none')
  add_pokemon(conn, 'Sunflora', 'Grass', 'none')
  add_pokemon(conn, 'Yanma', 'Bug', 'Flying')
  add_pokemon(conn, 'Wooper', 'Water', 'Ground')
  add_pokemon(conn, 'Quagsire', 'Water', 'Ground')
  add_pokemon(conn, 'Espeon', 'Psychic', 'none')
  add_pokemon(conn, 'Umbreon', 'Dark', 'none')
  add_pokemon(conn, 'Murkrow', 'Dark', 'Flying')
  add_pokemon(conn, 'Slowking', 'Water', 'Psychic')
  add_pokemon(conn, 'Misdreavus', 'Ghost', 'none')
  add_pokemon(conn, 'Unown', 'Psychic', 'none')
  add_pokemon(conn, 'Wobbuffet', 'Pyschic', 'none')
  add_pokemon(conn, 'Girafarig', 'Normal', 'Psychic')
  add_pokemon(conn, 'Pineco', 'Bug', 'none')
  add_pokemon(conn, 'Forretress', 'Bug', 'Steel')
  add_pokemon(conn, 'Dunsparce', 'Normal', 'none')
  add_pokemon(conn, 'Gligar', 'Ground', 'Flying')
  add_pokemon(conn, 'Steelix', 'Steel', 'Ground')
  add_pokemon(conn, 'Snubbull', 'Normal', 'none')
  add_pokemon(conn, 'Granbull', 'Normal', 'none')
  add_pokemon(conn, 'Qwilfish', 'Water', 'Poison')
  add_pokemon(conn, 'Scizor', 'Bug', 'Steel')
  add_pokemon(conn, 'Shuckle', 'Bug', 'Rock')
  add_pokemon(conn, 'Heracross', 'Bug', 'Fighting')
  add_pokemon(conn, 'Sneasel', 'Dark', 'Ice')
  add_pokemon(conn, 'Teddiursa', 'Normal', 'none')
  add_pokemon(conn, 'Ursaring', 'Normal', 'none')
  add_pokemon(conn, 'Slugma', 'Fire', 'none')
  add_pokemon(conn, 'Magcargo', 'Fire', 'Rock')
  add_pokemon(conn, 'Swinub', 'Ice', 'Ground')
  add_pokemon(conn, 'Piloswine', 'Ice', 'Ground')
  add_pokemon(conn, 'Corsola', 'Water', 'Rock')
  add_pokemon(conn, 'Remoraid', 'Water', 'none')
  add_pokemon(conn, 'Octillery', 'Water', 'none')
  add_pokemon(conn, 'Delibird', 'Ice', 'Flying')
  add_pokemon(conn, 'Mantine', 'Water', 'Flying')
  add_pokemon(conn, 'Skarmory', 'Steel', 'Flying')
  add_pokemon(conn, 'Houndour', 'Dark', 'Fire')
  add_pokemon(conn, 'Houndoom', 'Dark', 'Fire')
  add_pokemon(conn, 'Kingdra', 'Water', 'Dragon')
  add_pokemon(conn, 'Phanpy', 'Ground', 'none')
  add_pokemon(conn, 'Donphan', 'Ground', 'none')
  add_pokemon(conn, 'Porygon2', 'Normal', 'none')
  add_pokemon(conn, 'Stantler', 'Normal', 'none')
  add_pokemon(conn, 'Smeargle', 'Normal', 'none')
  add_pokemon(conn, 'Tyrogue', 'Fighting', 'none')
  add_pokemon(conn, 'Hitmontop', 'Fighting', 'none')
  add_pokemon(conn, 'Smoochum', 'Ice', 'Psychic')
  add_pokemon(conn, 'Elekid', 'Magby', 'none')
  add_pokemon(conn, 'Miltank', 'Normal', 'none')
  add_pokemon(conn, 'Blissey', 'Normal', 'none')
  add_pokemon(conn, 'Raikou', 'Electric', 'none')
  add_pokemon(conn, 'Entei', 'Fire', 'none')
  add_pokemon(conn, 'Suicune', 'Water', 'none')
  add_pokemon(conn, 'Larvitar', 'Rock', 'Ground')
  add_pokemon(conn, 'Pupitar', 'Rock', 'Ground')
  add_pokemon(conn, 'Tyranitar', 'Rock', 'Ground')
  add_pokemon(conn, 'Lugia', 'Psychic', 'Flying')
  add_pokemon(conn, 'Ho-Oh', 'Fire', 'Flying')
  add_pokemon(conn, 'Celebi', 'Psychic', 'Grass')
end
