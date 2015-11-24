require 'rails_helper'

RSpec.describe CardSlot, type: :model do
  describe "CardSlot should test validations" do
    let(:card_slot) { CardSlot.new }

    it "should validate the presence of a card_id" do
      card_slot.save
      expect(card_slot.errors[:card_id]).to include("can't be blank")
    end

    it "should validate the presence of a deck_id" do
      card_slot.save
      expect(card_slot.errors[:deck_id]).to include("can't be blank")
    end

    it "should set the default value of 'location' to 'main deck'" do
      card_slot.save
      expect(card_slot.location).to eq("main deck")
    end

    it "should set the default value of 'quanitity' to 1" do
      card_slot.save
      expect(card_slot.quantity).to eq(1)
    end

  end
end
