class CocktailRecipesController < ApplicationController 
    skip_before_action :verify_authenticity_token
    before_action :find_cocktail_recipe, only: [:show, :edit, :update, :destroy] 
    before_action :authenticate_user!

    def new 
        @cocktail_recipe = CocktailRecipe.new 
    end  

    def create
      @cocktail_recipe = current_user.cocktail_recipes.new(cocktail_recipe_params) 
      if @cocktail_recipe.save 
        redirect_to cocktail_recipe_path(@cocktail_recipe), notice: "Your recipe has successfully been added"  
      else 
        render :new 
      end     
    end
    
    def show   
      @comment = current_user.comments.build(cocktail_recipe: @cocktail_recipe) 
      respond_to do |format|
        format.html { render :show }
        format.json { render json: @cocktail_recipe }
      end
    end 

    def index 
      @users = User.all   
      if params[:search]
        @cocktail_recipes = CocktailRecipe.search(params[:search]).order("created_at DESC")
      elsif !params[:user].blank?
        @cocktail_recipes = CocktailRecipe.by_user(params[:user]).order(:title)
      elsif params[:user_id]
        @cocktail_recipes = User.find(params[:user_id]).cocktail_recipes.order('title ASC')
      else
        @cocktail_recipes = CocktailRecipe.all.order(:title)
      end
    end 


    def edit  
    end

    def destroy 
      @cocktail_recipe.destroy
      redirect_to cocktail_recipes_url
    end
     
    def update
      if @cocktail_recipe.update(cocktail_recipe_params)
        redirect_to @cocktail_recipe, notice: "Your recipe has successfully been updated"
      else 
        redirect_to new_cocktail_recipe_path
      end
    end

    private

    def cocktail_recipe_params
      params.require(:cocktail_recipe).permit(:user_id, :category_name, :title, :directions, :description, :avatar) 
    end 


    def find_cocktail_recipe
     @cocktail_recipe = CocktailRecipe.find(params[:id])
    end
    
end
