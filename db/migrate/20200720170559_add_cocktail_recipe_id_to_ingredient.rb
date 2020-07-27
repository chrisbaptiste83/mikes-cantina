class AddCocktailRecipeIdToIngredient < ActiveRecord::Migration[6.0]
  def change 
    add_column :ingredients, :cocktail_recipe_id, :integer
  end
end
