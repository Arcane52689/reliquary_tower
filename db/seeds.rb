# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


def seed_categories(list)
  list.each do |cat|
    Category.create(name: cat)
  end

end

def seed_sets
  file_name = Rails.root.join 'lib', 'assets', 'AllSets.json'

  file = File.open(file_name)

  data = JSON.parse(file.read)

  data.keys.each do |k|
    next if CardSet.exists?(code: k);
    CardSet.create({
      name: data[k]['name'],
      code: k,
      is_seeded: false
    })
  end

  file.close

end

def seed_set(number)
  file_name = Rails.root.join 'lib', 'assets', 'AllSets.json'

  file = File.open(file_name)

  data = JSON.parse(file.read)
  number.times do
    set = CardSet.where(is_seeded: false).first
    cards = data[set.code]['cards']
    cards.each do |card_data|
      multiverse_id = card_data["multiverseid"]
      next if multiverse_id.nil? || Printing.exists?(multiverse_id: multiverse_id)
      printing = set.printings.create_from_json(card_data)
      byebug if printing.id.nil?
    end
    set.is_seeded = true
    set.save
    p set.name
  end
  file.close
end


# seed_categories(['enchantments', 'auras', 'general damage', 'weenies', 'combo'])
# seed_sets
seed_set(10)
