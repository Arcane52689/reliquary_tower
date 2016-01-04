require 'rails_helper'

RSpec.describe User, type: :model do


  describe "User should validate presence of attributes" do
    let(:user) { User.new({ password: 'abcdef', username: "me", email: "me@me.me"})}

    it "should save if there are no errors" do
      user.save
      expect(user.id).to_not eq(nil)
    end

    it "should require a password of at least 6 characters" do
      user.password = '123'
      user.save
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end


    it "should require a username" do
      user.username = nil
      user.save
      expect(user.errors[:username]).to include("can't be blank")
    end

    it "should check for email address to be present" do
      user.email = nil
      user.save
      expect(user.errors[:email]).to include("can't be blank")
    end


    it "should require a valid email address" do

      user.email = "me"
      user.save
      expect(user.errors[:email]).to include("is invalid")
    end

    it "should set the default value for admin to false" do
      user.save
      expect(user.admin).to eq(false)
    end

  end

  describe "User should validate uniqueness of email and username" do
    let(:user1) { User.create(password:"123456", email:"me@me.me", username:"me")}
    let(:user2) { User.create(password:"123456", email:"you@you.you", username:"you")}


    it "should ensure a unique username" do
      user2.username = user1.username
      user2.save
      expect(user2.errors[:username]).to include("has already been taken")
    end

    it "should ensure a unique email address" do
      user2.email = user1.email
      user2.save
      expect(user2.errors[:email]).to include("has already been taken")
    end



  end

  describe "User should be found and identified by credentials" do
    let(:user) { User.create(
      username: "me",
      password: "mememe",
      email: "me@me.me"
      )}

    it "should look users up by email" do
      user.save
      found_user = User.find_by_credentials("me@me.me", "mememe")
      expect(found_user).to eq(user)
    end

    it "should look users up by username" do
      user.save
      found_user = User.find_by_credentials("me", "mememe")
      expect(found_user).to eq(user)
    end

    it "should return nil if the wrong password is given" do
      user.save
      found_user = User.find_by_credentials("me@me.me", "123345")
      expect(found_user).to eq(nil)
    end





  end

end
