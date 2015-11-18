class Session < ActiveRecord::Base

  validates :token, uniqueness: true, presence: true
  validates :user_id, presence: true
  before_validation :ensure_unique_token



  belongs_to :user


  def self.find_user_by_token(session_token)
    session = Session.find_by(token: session_token)
    return session.user if session
    nil
  end

  def ensure_unique_token
    self.token ||= SecureRandom.urlsafe_base64(16)
    while Session.exists?(token: self.token)
      self.token = SecureRandom.urlsafe_base64(16)
    end
    self.token
  end

end
