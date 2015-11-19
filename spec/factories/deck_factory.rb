
FactoryGirl.define do


  factory :deck do
    user
    name "test_deck"
  end

  factory :commander do
    user
    name "mememe"
  end

  factory :tiny_leaders do
    user
    name 'tiny'
  end

  factory :standard do
    user
    name "standard"
  end

  factory :modern do
    user
    name "modern"
  end


end
