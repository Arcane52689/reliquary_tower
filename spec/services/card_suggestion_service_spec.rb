require 'rails_helper'
require './app/services/card_suggestion_service.rb'



describe "CardSuggestionService" do
  before(:all) do
    @category = create(:category)
    create(:legendary_creature).taggings.create(category_id: @category.id)
    create(:tiny_leader).taggings.create(category_id: @category.id)
    create(:planeswalker_commander).taggings.create(category_id: @category.id)
    create(:tiny_planeswalker).taggings.create(category_id: @category.id)
  end
  describe "commander" do


    it "should find all commander cards in the appropriate colors and categories" do
      results = CardSuggestionService.commander(["Green","Red"], [@category.id])
      names = results.map(&:name)
      expect(names).to contain_exactly("test legend")
    end

    it "should return a list of all options if no colors are passed in" do
      results = CardSuggestionService.commander([], [@category.id])
      names = results.map(&:name)
      expect(names).to contain_exactly("test legend", "test tiny leader", "test planeswalker",  'nissa')
    end

    it "should return a list of all options if no categories are passed in" do
      results = CardSuggestionService.commander(["White"], [])
      names = results.map(&:name)
      expect(names).to contain_exactly("test planeswalker")
    end

  end


  describe "tiny_leader" do

    it "should return a list of all possible tiny leaders" do
      results = CardSuggestionService.tiny_leader([], [])
      names =  results.map(&:name)
      expect(names).to contain_exactly("test tiny leader", "nissa")
    end

    it "should not return any cards with a cmc greater than 3" do
      results = CardSuggestionService.tiny_leader([], [])
      expect(results.any? { |m| m.cmc > 3 }).to eq(false)
    end

  end


end
