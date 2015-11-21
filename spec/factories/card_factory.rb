FactoryGirl.define do

  factory :card do


    name 'Test'
    mana_cost '{W}{U}{B}{R}{G}}'
    cmc 5
    rarity 'common'
    card_text ""
    multiverse_id 52123


    factory :legendary_creature do
      supertypes ["Legendary", "Creature"]
      mana_cost "2{G}"
      card_text "{U//R}"
    end


    factory :planewalker do
      supertypes ["Planeswalker"]

      factory :planeswalker_commander do
        mana_cost '2{W}{W}'
        can_be_commander true
      end

    end

  end


end
