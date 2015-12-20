FactoryGirl.define do
  factory :category do
    name "testing"

    factory :elves do
      name "Elves"
      is_tribal true
    end

    factory :elementals do
      name 'Elementals'
      is_tribal true
    end

    factory :merfolk do
      name 'Merfolk'
      is_tribal true
    end
  end
end
