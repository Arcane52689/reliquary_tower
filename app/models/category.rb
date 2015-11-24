class Category < ActiveRecord::Base

  has_many :taggings, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  before_validation :titleize_name


  def titleize_name
    self.name = self.name.titleize if self.name
    true
  end


end
