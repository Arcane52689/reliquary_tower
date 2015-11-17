class User < ActiveRecord::Base
  attr_reader :password


  has_many :decks




  def self.find_by_credentials(email, password)
    user = User.find_by({
      email: email
    })
    return nil unless user
    return user if user.is_password?(password)
    nil
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end


end
