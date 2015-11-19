FactoryGirl.define do

  factory :card do
    name 'Test'
    mana_cost '{W}{U}{B}{R}{G}}'
    cmc 5
    rarity 'common'
    card_text ""
    multiverse_id 52123
  end


end
