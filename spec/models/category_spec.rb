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







  end


end
