# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#seed some cards

file_name = Rails.root.join 'lib', 'assets', 'AllSets.json'

file = File.read(file_name)

data = JSON.parse(file)
data.keys.each do |set|
  set_data = data[set]
  set_data["name"]

end


# next if Card.exists(multiverse_id: c["mul"])
# Card.new( {
#   mana_cost: c["manaCost"] || "",
#   name: c["name"],
#   cmc: c["cmc"],
#   colors: c["colors"],
#   supertypes: c["supertypes"],
#   types: c["types"],
#   subtypes: c["subtypes"],
#   card_text: c["text"],
#   multiverse_id: c["multiverse_id"]
#
#   })
