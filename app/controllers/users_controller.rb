class UsersController < ApplicationController 
    skip_before_action :verify_authenticity_token
    def index 
    end 


    def show
        @user = User.find(params[:id]) 
        @cocktail_recipes = CocktailRecipe.all
    end 

    

end
