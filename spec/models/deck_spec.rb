require 'rails_helper'

RSpec.describe Deck, type: :model do


  describe "Deck validations" do
    let(:deck) { Deck.new }

    it "should require a name to save it" do
      deck.save
      expect(deck.errors[:name]).to include("can't be blank")
    end

    it "should save as long as a name is present" do
      deck.name = "testing"
      expect(deck.save).to eq(true)
    end

  end

  describe "Deck subclasses" do
    let(:user) { User.create(username:"me", email: "me@me.me", password:"mememe")}
    let(:commander) { user.commander_decks.create(name: "commander1")}
    let(:standard)  { user.standard_decks.create(name: "standard1")}
    let(:modern)    { user.modern_decks.create(name: "modern1")}
    let(:tiny)     { user.tiny_leaders_decks.create(name: "tiny1")}

    it "should create deck with the proper format" do
      expect(commander.format).to eq("Commander")
      expect(standard.format).to eq("Standard")
      expect(modern.format).to eq("Modern")
      expect(tiny.format).to eq("Tiny Leaders")
    end

    it "should create decks with the proper minimum number of cards" do
      expect(commander.card_minimum).to eq(100)
      expect(tiny.card_minimum).to eq(50)
      expect(modern.card_minimum).to eq(60)
      expect(standard.card_minimum).to eq(60)
    end

    it "should create decks with the proper maximum number of cards" do
      expect(commander.card_limit).to eq(100)
      expect(tiny.card_limit).to eq(50)
      expect(modern.card_limit).to eq(Float::INFINITY)
      expect(standard.card_limit).to eq(Float::INFINITY)
    end


  end


end
