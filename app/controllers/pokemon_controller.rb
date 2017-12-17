class PokemonController < ApplicationController

  def show
    response = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(response.body)
    name  = body["name"]
    id = body["id"]
    types = body["types"].map {|type| type["type"]["name"]}

    response_gif = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV['GIPHY_KEY']}&q=#{name}&rating=pg")
    body_gif = JSON.parse(response_gif.body)
    gif_url = body_gif["data"][0]["url"]


    render json: {
      id: id,
      name: name,
      types: types,
      gif: gif_url,
    }

  end


end
