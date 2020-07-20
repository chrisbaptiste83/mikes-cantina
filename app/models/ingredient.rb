class Ingredient < ApplicationRecord 
    belongs_to :formula 

    def self.search(search)
        where("name LIKE ?", "%#{search}%") 
      end
end
