require 'rails_helper'

RSpec.describe Deck, type: :model do


  describe "Deck validations" do
    let(:deck) { Deck.new }

    it "should require a name to save it" do
      deck.save
      expect(deck.errors[:name]).to include("can't be blank")
    end

    it "should require a user_id to be present" do
      deck.save
      expect(deck.errors[:user_id]).to include("can't be blank")
    end

    it "should save as long as a name is present" do
      deck.name = "testing"
      deck.user_id = 1
      expect(deck.save).to eq(true)
    end

  end

  describe "Deck methods" do


    describe "Deck.all_in_format" do
      before(:all) do
        @user = User.first || User.create({
          username: 'testing',
          password: 'testing',
          email: 'test@test.test'
          })
        @user.commander_decks.create(name: 'deck1')
        @user.commander_decks.create(name: 'deck2')
        @user.commander_decks.create(name: 'deck3')

        @user.standard_decks.create(name: 'deck1')
        @user.standard_decks.create(name: 'deck2')

        @user.modern_decks.create(name: 'deck1')

      end

      it "should return all decks in the specified format" do
        expect(Deck.all_in_format('Commander').length).to eq(3)
        expect(Deck.all_in_format('Standard').length).to eq(2)
        expect(Deck.all_in_format('Modern').length).to eq(1)
        expect(Deck.all_in_format('Tiny Leaders').length).to eq(0)
      end

      it "should assume the format based on the deck subclass" do
        expect(Commander.all_in_format.length).to eq(3)
        expect(Standard.all_in_format.length).to eq(2)
        expect(Modern.all_in_format.length).to eq(1)
        expect(TinyLeaders.all_in_format.length).to eq(0)
      end

    end

    describe "add_cards" do
      let(:deck) { create(:deck) }
      let(:card) { create(:card)}
      let(:card2) { create(:card) }

      it "should add a single card to the deck if passed a single card" do
        deck.add_cards(card.id)
        expect(deck.cards.length).to eq(1)
      end

      it "should add multiple cards to the deck if passed an array" do
        cards = [card.id, card2.id]
        deck.add_cards(cards)
        expect(deck.cards.length).to eq(2)
      end

      it "if the card_id is already in the deck, it should increase the quantity of the card slot instead of creating a new card" do
        cards = [card.id, card.id, card2.id, card2.id]
        deck.add_cards(cards)
        expect(deck.card_slots.length).to eq(2)
      end

      it "should accept a location as a secondary argument and add the cards there" do
        cards = [card.id, card2.id]
        deck.add_cards(cards, 'sideboard')
        expect(deck.card_slots.first.location).to eq("sideboard")
      end

    end

    describe "total_cards_in Location" do
      before(:each) do
        @deck = create(:deck)
        cards = Array.new(10) { create(:card).id }
        @deck.add_cards(cards)
        side_board = Array.new(5) { create(:card).id }
        @deck.add_cards(side_board, "sideboard")
      end

      it "return the number of cards in the specified location" do
        main_deck = @deck.total_cards_in("main deck")
        sideboard = @deck.total_cards_in("sideboard")
        expect(main_deck).to eq(10)
        expect(sideboard).to eq(5)
      end

    end


  end

  describe "Deck subclasses" do
    let(:user) { create(:user)}

    describe "Commander" do
      let(:commander) { create(:commander) }

      it "should create deck with the proper format" do
        expect(commander.format).to eq("Commander")
      end

      it "should create decks with the proper minimum number of cards" do
        expect(commander.card_minimum).to eq(99)
      end

      it "should create decks with the proper maximum number of cards" do
        expect(commander.card_limit).to eq(99)
      end


    end

    describe "Tiny Leaders" do
      let(:tiny)      { create(:tiny_leaders) }

      it "should create deck with the proper format" do
        expect(tiny.format).to eq("Tiny Leaders")
      end

      it "should create decks with the proper minimum number of cards" do
        expect(tiny.card_minimum).to eq(49)
      end

      it "should create decks with the proper maximum number of cards" do
        expect(tiny.card_limit).to eq(49)
      end



    end

    describe "Standard" do
      let(:standard)  { create(:standard) }

      it "should create deck with the proper format" do
        expect(standard.format).to eq("Standard")
      end

      it "should create decks with the proper minimum number of cards" do
        expect(standard.card_minimum).to eq(60)
      end

      it "should create decks with the proper maximum number of cards" do
        expect(standard.card_limit).to eq(Float::INFINITY)
      end


    end

    describe "Modern" do
      let(:modern)    { create(:modern) }

      it "should create deck with the proper format" do
        expect(modern.format).to eq("Modern")
      end

      it "should create decks with the proper minimum number of cards" do
        expect(modern.card_minimum).to eq(60)
      end

      it "should create decks with the proper maximum number of cards" do
        expect(modern.card_limit).to eq(Float::INFINITY)
      end
    end








  end




end
