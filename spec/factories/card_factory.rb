FactoryGirl.define do

  factory :card do


    name 'Test'
    mana_cost '{W}{U}{B}{R}{G}}'
    cmc 5
    rarity 'common'
    card_text ""
    multiverse_id 52123


    factory :legendary_creature do
      name 'test legend'
      supertypes ["Legendary"]
      types ["Creature"]
      mana_cost "3{G}"
      cmc 4
      card_text "{U//R}"


      factory :tiny_leader do
        name 'test tiny leader'
        mana_cost "2B"
        cmc 3
        card_text "{U//R}"

      end
    end

    factory :planewalker do
      types ["Planeswalker"]
      name "test planeswalker"
      factory :planeswalker_commander do
        mana_cost '2{W}{W}'
        cmc 4
        can_be_commander true
      end

      factory :tiny_planeswalker do
        mana_cost '1G'
        cmc 3
        name "nissa"
        can_be_commander true
      end

    end


    factory :land do
      types ["Land"]
      mana_cost ""
      colors []
      card_text "{T}: Add {1} to your mana pool"

      factory :basic_land do
        supertypes ["Basic"]

        factory :forest do
          subtypes ['forest']
          card_text '{T}: Add {G} to your mana pool'
        end

        factory :mountain do
          subtypes ['mountain']
          card_text ['{T}: Add {R} to your mana pool']
        end
        factory :swamp do
          subtypes ['swamp']
          card_text ['{T}: Add {B} to your mana pool']
        end
        factory :island do
          subtypes ['island']
          card_text ['{T}: Add {U} to your mana pool']
        end
        factory :plains do
          subtypes ['plains']
          card_text ['{T}: Add {W} to your mana pool']
        end


      end

    end

  end


end
