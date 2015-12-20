require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "validations" do


    it "should require a name to save" do
      category = Category.new
      category.save
      expect(category.errors[:name]).to include("can't be blank")
    end

    let(:category) { build(:category)}

    it "should titleize the name before saving it" do
      category.save
      expect(category.name).to eq("Testing")
    end

    it "should ensure the name is unique" do
      create(:category)
      category.save
      expect(category.errors[:name]).to include("has already been taken")
    end



    describe "generate_query" do
      let(:elves) { create :elves }
      let(:category) { create :category}

      it "should generate a query string" do
        query, arguments = category.generate_query
        expect(query).to eq("category_id = ?")
        expect(arguments).to eq([3])
      end

      describe "tribal key words" do

        it "should turn a plural name into a singular" do

          query, arguments = elves.generate_query
          expect(query).to eq("? = ANY (subtypes) OR UPPER(card_text) LIKE UPPER(?) OR UPPER(card_text) LIKE UPPER(?) OR UPPER(card_text) LIKE UPPER(?)")
          expect(arguments).to eq(['Elf', 'Elf', '%Elves%'])
        end



      end


    end



  end


end
