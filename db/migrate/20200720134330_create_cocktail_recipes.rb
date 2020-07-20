class CreateCocktailRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :cocktail_recipes do |t|

      t.timestamps
    end
  end
end
