class CocktailRecipe < ApplicationRecord
    belongs_to :user
    belongs_to :category 
    has_many :comments 
    has_many :ingredients
    accepts_nested_attributes_for :ingredients, :allow_destroy => true

    validates :title, :description, :directions, :category_name, presence: true  

    has_attached_file :avatar, :styles => { :medium => "200x200#"}

    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/ 

    scope :most_comments, -> { order("comments_count DESC").first } 
    scope :five_latest_cocktail_recipes,  -> { order("created_at desc").limit(5)}
    scope :of_the_day,  -> { order('RANDOM()').first}

    def category_name=(name)
      self.category = Category.find_or_create_by(name: name)
   end
  
   def category_name
       self.category ? self.category.name : nil
   end 
    
    def self.by_user(user_id)
      where(user: user_id)
    end
     
    def self.search(search)
      where("title LIKE ?", "%#{search}%") 
    end

    def previous
        CocktailRecipe.all.order(:title).where("title < ?", title).last
    end
      

    def next
        CocktailRecipe.all.order(:title).where("title > ?", title).first
    end


    

    def delete_ingredients_from_recipe
        ingredients.size.times do
        ingredient = RecipeIngredient.find_by(cocktail_recipe_id: self.id)
        ingredient.delete
     end
    end 

  end

