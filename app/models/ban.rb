class Ban < ActiveRecord::Base

  validates :card_name, :format, presence: true

  validate :unique_ban



  def unique_ban
    if Ban.exists?(card_name: self.card_name, format: self.format)
      self.errors[:card_name] << " is already banned in this format"
    end
  end


end
