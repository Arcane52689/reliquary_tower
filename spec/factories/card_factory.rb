FactoryGirl.define do

  factory :card do


    name 'Test'
    mana_cost '{W}{U}{B}{R}{G}}'
    cmc 5
    rarity 'common'
    card_text ""
    multiverse_id 52123


    factory :legendary_creature do
      supertypes ["Legendary"]
      types ["Creature"]
      mana_cost "2{G}"
      card_text "{U//R}"
    end


    factory :planewalker do
      types ["Planeswalker"]

      factory :planeswalker_commander do
        mana_cost '2{W}{W}'
        can_be_commander true
      end

    end


    factory :land do
      types ["Land"]
      mana_cost ""

      factory :basic_land do
        supertypes ["Basic"]
      end

    end

  end


end
