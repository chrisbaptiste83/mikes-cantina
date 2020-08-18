// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

  

  class CocktailAPI {
  
  
    static getIngredients() {
      return fetch(`${CocktailAPI.base_url}/ingredients`).then(res => res.json())
    } 
  
  
    static createIngredient(ingredientAttributes) { 
      return fetch(`${CocktailAPI.base_url}/ingredients`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: JSON.stringify(ingredientAttributes)
      })
        .then(res => res.json())
    } 
  
    static deleteIngredient(cocktailId,ingredientId){ 
      return fetch(`${CocktailAPI.base_url}/cocktail_recipes/${cocktailId}/ingredients/${ingredientId}`,{
        method:'DELETE'
      }) 
        .then(res => res.json())
    }
  }  
  
  CocktailAPI.base_url = "http://localhost:3000"
  
  
  class Ingredient { 
    constructor({id, name, cocktail_recipe_id}) {
      this.id = id
      this.name = name
      this.cocktail_recipe_id = cocktail_recipe_id 
    }
  
    static findOrCreateBy(attributes) {
      let found = Ingredient.all.find(ingredient => ingredient.id == attributes.id)
      return found ? found : new Ingredient(attributes).save()
    } 
  
    static addIngredientField(){
      return ` 
        <form class="addIngredient">
          <p>
            <h3><label class="db">Add Quantity and Ingredient:</label></h3>
            <input type="text" class="db w-60" name="ingredient" id="ingredient" /><br> 
          </p>   
          <input type="submit" value="Add Ingredient to Cocktail" />  
        </form>
        ` 
    } 
  
  
    static findById(id) {
      return Ingredient.all.find(ingredient => ingredient.id == id)
    }
  
    static create(ingredientAttributes) {
      return CocktailAPI.createIngredient(ingredientAttributes)
        .then(ingredientJSON => { 
          return new Ingredient(ingredientJSON).save()
        })
    } 
  
    remove() { 
        return CocktailAPI.deleteIngredient(this.cocktail_recipe_id, this.id)
          .then(ingredient => {
            let newIngredients = Ingredient.all.filter(ing => ing.id != ingredient.id)
            Ingredient.all = newIngredients
          })   
    } 
  
    save() {
      Ingredient.all.push(this)
      return this
    }
  
    render() {
      return `
      <ul class="f3 light-gray fw4 mt2 black-60"><big>${this.name}</big> <button class="deleteIngredient f6 link dim br-pill ph3 pv2 mb2 dib white bg-black" data-ingredient-id="${this.id}">Delete</button></ul>

        
      `
    }
  
  }
  
  Ingredient.all = [] 
  
  document.addEventListener('DOMContentLoaded', () => {
  
    document.addEventListener('click', (e) => {
        if(e.target.matches('.deleteIngredient')) { 
          let ingredient = Ingredient.findById(e.target.dataset.ingredientId) 
          ingredient.remove()
            .then(ingredient => {
              cocktailIngredient = e.target.parentElement
              cocktailIngredient.remove() 
            }) 
        } 
        if(e.target.matches('.deleteButton')) { 
          let cocktail_id = document.URL.split('/')[4]  
          ingredient.remove()
            .then(ingredient => {
              cocktailIngredient = e.target.parentElement
              cocktailIngredient.remove() 
            }) 
        } 
        if(e.target.matches('.deleteIngredients')) { 
          let cocktailRecipeId = document.URL.split('/')[4] 
          let ingredientId = e.target.dataset.ingredientId 
          return CocktailAPI.deleteIngredient(cocktailRecipeId, ingredientId)
          .then(ingredient => {
            let newIngredients = Ingredient.all.filter(ing => ing.id != ingredient.id)
            Ingredient.all = newIngredients
          }) 
            .then(ingredient => {
              cocktailIngredient = e.target.parentElement
              cocktailIngredient.remove() 
            }) 
        }          
        if(e.target.matches('.addIngredient')) {
          document.querySelector('#ingredients2').insertAdjacentHTML('beforeend', Ingredient.addIngredientField())
        }    
    }) 
  
    document.addEventListener('submit', (e) => {
        if(e.target.matches('.addIngredient')) { 
          e.preventDefault() 
          let ingredientData = {} 
          ingredientData.name = document.querySelector('input[type="text"]').value
          ingredientData.cocktail_recipe_id = document.URL.split('/')[4] 
          Ingredient.create(ingredientData) 
            .then(ingredient => { 
            document.querySelector('#ingredients').insertAdjacentHTML('beforeend', ingredient.render())
            }) 
        }
        
    })
  })
  

  
    