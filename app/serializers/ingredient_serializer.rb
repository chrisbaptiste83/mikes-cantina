class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name, :cocktail_recipe_id
end
