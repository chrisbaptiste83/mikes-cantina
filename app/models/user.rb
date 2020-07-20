class User < ApplicationRecord  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :cocktail_recipes 
    has_many :comments 
    validates :username, presence: true, uniqueness: true    
    validates :email, presence: true
end
