require 'rails_helper'

RSpec.describe Ban, type: :model do
  let(:ban) { create(:ban)}
  it 'should validate the presence of a card_name' do
    ban.card_name = nil
    ban.save
    expect(ban.errors.full_messages).to include("Card name can't be blank")
  end

  it 'should validate the presence of a card_name' do
    ban.format = nil
    ban.save
    expect(ban.errors.full_messages).to include("Format can't be blank")
  end

  it 'should validate a unique format/card_name combination' do
    ban
    new_ban = build(:ban)
    new_ban.save
    expect(new_ban.errors.full_messages).to include("Card name  is already banned in this format")
  end
end
