require 'rails_helper'

RSpec.describe Card, type: :model do
  describe "validation tests" do
    let(:card) { Card.new }
    it "validates that a name is present" do
      card.save
      expect(card.errors[:name]).to include("can't be blank")
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



  describe "card.methods" do


    describe "type check methods" do
      let(:legendary_creature) { create(:legendary_creature)}
      let(:card) { create(:card) }

      it "should check if the card is legendary" do
        expect(legendary_creature.is_legendary?).to eq(true)
        expect(card.is_legendary?).to eq(false)
      end

      it "should check if the card is a creature" do
        expect(legendary_creature.is_creature?).to eq(true)
        expect(card.is_creature?).to eq(false)
      end


      it "should check if the card is a legendary creature" do
        expect(legendary_creature.is_legendary_creature?).to eq(true)
        expect(card.is_legendary_creature?).to eq(false)
      end


      let(:basic_land) { create(:basic_land)}
      it "should check if the card is a basic land" do
        expect(basic_land.is_basic?).to eq(true)
      end

    end

    describe "commander methods" do
      let(:planeswalker_commander) { create(:planeswalker_commander) }
      let(:card) {create(:card) }
      let(:legendary_creature) { create(:legendary_creature )}


      it "should keep track of whether a card can be a commander or not" do
        expect(planeswalker_commander.can_be_commander?).to eq(true)
        expect(card.can_be_commander?).to eq(false)
        expect(legendary_creature.can_be_commander?).to eq(true)
      end

      it "should parse the color identity  in a cards manacost" do
        expect(card.color_identity).to contain_exactly("Red", "White", "Blue", "Green", "Black")
        expect(planeswalker_commander.color_identity).to contain_exactly("White")
      end

      it "should parse the color identity in a cards text box" do
        expect(legendary_creature.color_identity).to contain_exactly("Red", "Green","Blue",)
      end

    end





  end
end
