class User < ActiveRecord::Base
  attr_reader :password


  has_many :decks, dependent: :destroy
  has_many :sessions, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /@/
  validates :password, length: { minimum: 6 }, allow_nil: true


  def self.find_by_credentials(email_or_username, password)
    if email_or_username.match(/.*\@.*\..*/)
      user = self.find_by(email: email_or_username)
    end
    unless user
      user = self.find_by(username: email_or_username)
    end

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
