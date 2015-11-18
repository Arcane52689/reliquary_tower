require 'rails_helper'

RSpec.describe Session, type: :model do
  let(:user) { User.create({email: "me@me.me", username: "Me", password:"mememe"})}


  it "should ensure a unique session token" do
    session1 = user.sessions.create
    session2 = user.sessions.create
    session2.token = session1.token
    session2.save
    expect(session2.token).to_not eq(session1.token)
  end

  it "should require a valid user_id" do
    s = Session.new()
    s.save
    expect(s.errors[:user_id]).to include("can't be blank")
  end

  it "should find a user by the session token" do
    session1 = user.sessions.create()
    user2 = Session.find_user_by_token(session1.token)
    expect(user).to eq(user2)
  end



end
