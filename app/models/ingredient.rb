class Ingredient < ApplicationRecord 
    belongs_to :cocktail_recipe

    def self.search(search)
      where("name LIKE ?", "%#{search}%") 
    end
end
