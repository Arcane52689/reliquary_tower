# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#seed some cards

def seed_categories(list)
  list.each do |cat|
    Category.create(name: cat)
  end

end

def seed_sets

  file_name = Rails.root.join 'lib', 'assets', 'AllSets.json'

  file = File.read(file_name)

  data = JSON.parse(file)
  data.keys.each do |k|
    CardSet.create({
      name: data[k]['name'],
      code: k,
      is_seeded: false
    })
  end

end

def seed_set
  file_name = Rails.root.join 'lib', 'assets', 'AllSets.json'

  file = File.read(file_name)

  data = JSON.parse(file)


  set = CardSet.where(is_seeded: false).first

  cards = data[set.code]['cards']
  cards.each do |card_data|
    next if Card.exists?(multiverse_id: card_data['multiverseid'])
    card = set.cards.create_from_json(card_data)
  end
  set.is_seeded = true
  set.save
  p set.name
end

10.times { seed_set }


# seed_sets
