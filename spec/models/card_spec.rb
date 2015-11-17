require 'rails_helper'

RSpec.describe Card, type: :model do

  let(:card) { Card.new }
  it "validates that a name is present" do
    card.save
    expect(card.errors[:name]).to include("can't be blank")
  end

  it "validates that the mana_cost is present" do
    card.save
    expect(card.errors[:mana_cost]).to include("can't be blank")
  end

  it "validates that the converted_mana_cost is present" do
    card.save
    expect(card.errors[:cmc]).to include("can't be blank")
  end

  it "validates that the rarity is present" do
    card.save
    expect(card.errors[:rarity]).to include("can't be blank")
  end

  it "does not accept invalid colors" do
    card.colors = ['Red', 'Blue', 'Purple']
    card.save
    expect(card.errors[:colors]).to include("Purple is not a valid color. Must be one of the following: Blue, White, Black, Green, Red")
  end



end
