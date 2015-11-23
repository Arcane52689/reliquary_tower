class Tagging < ActiveRecord::Base
  belongs_to :category

  belongs_to :taggable, polymorphic: true


end
