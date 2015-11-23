require 'rails_helper'

RSpec.describe Tagging, type: :model do
  let(:card) { create(:card) }
  let(:category) { create(:category) }

  it "should ensure that the taggings are unique" do
    tag1 = card.taggings.create(category_id: category.id)
    tag2 = card.taggings.new(category_id: category.id)
    tag2.save
    expect(tag2.errors[:category_id]).to include("Tagging already exists for this category on this Card")
  end

end
