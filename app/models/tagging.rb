class Tagging < ActiveRecord::Base
  belongs_to :category

  belongs_to :taggable, polymorphic: true

  validate :ensure_unique_tagging



  def ensure_unique_tagging
    tag_list = Tagging.where(taggable_id: self.taggable_id).where(category_id: self.category_id).where(taggable_type: self.taggable_type)

    if tag_list.any? { |tag| tag.id != self.id }
      self.errors[:category_id] << "Tagging already exists for this category on this #{self.taggable_type}"
    end
  end


end
