class Category < ActiveRecord::Base

  has_many :taggings, dependent: :destroy

  validates :name, presence: true, uniqueness: true

  before_validation :titleize_name

  def self.query_string(category_ids)
    categories = self.where("id in (?)", category_ids)
    queries = []
    arguments = []

    categories.each do |category|
      query, argument = category.generate_query
      queries << query
      arguments.concat(argument)
    end

    return queries.join(" OR "), arguments

  end


  def titleize_name
    self.name = self.name.titleize if self.name
    true
  end


  def generate_query
    if self.is_keyword
      query = "UPPER(card_text) LIKE UPPER(?)"
      arguments = ["%#{self.name}%"]
    elsif self.is_tribal
      query = "? = ANY (subtypes) OR UPPER(card_text) LIKE UPPER(?) OR UPPER(card_text) LIKE UPPER(?)"
      arguments = [self.name.singularize, "%#{self.name.singularize}%", "%#{self.name.pluralize}%"]
    else
      query = "(taggings.category_id = ? AND taggings.taggable_type = 'Card'"
      arguments = [self.id]
    end
    return query, arguments
  end




end
