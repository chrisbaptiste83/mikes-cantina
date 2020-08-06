class CocktailRecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :user
end
