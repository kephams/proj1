class PokemonsController < ApplicationController
	def capture
		pokemon = Pokemon.find(params[:id])
		pokemon.trainer_id = current_trainer.id
		pokemon.save
		redirect_to root_path
	end
	def damage
		pokemon = Pokemon.find(params[:id])
		if pokemon.health <= 10
			Pokemon.destroy(params[:id])
		else
			pokemon.health -= 10
		end
		pokemon.save
		redirect_to trainer_path(pokemon.trainer_id)
	end
	def new
		@Pokemon = Pokemon.new

	end
	def create
		@pokemon = Pokemon.new
		@pokemon.name = params[:pokemon][:name]
		@pokemon.trainer_id = current_trainer.id
		@pokemon.health = 100
		@pokemon.level = 1

		if @pokemon.save then
			redirect_to trainer_path(current_trainer.id)
		else
			flash[:notice] = "Pokemon name cannot be empty and must be unique!"
			redirect_to new_pokemon_path
		end
	end
end
