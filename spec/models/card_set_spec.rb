require 'rails_helper'

RSpec.describe CardSet, type: :model do

  describe "validation testing" do
    let(:card_set) { CardSet.new }

    it "should require a name to be present before saving" do
      card_set.save
      expect(card_set.errors[:name]).to include("can't be blank")
    end

  end


end
