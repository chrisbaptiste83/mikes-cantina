class User < ApplicationRecord  
    has_many :cocktail_recipes 
    has_many :comments 
    validates :username, presence: true, uniqueness: true    
    validates :email, presence: true
end
