require 'sinatra/base'
require './lib/player'
require './lib/game'

class Battle < Sinatra::Base
  enable :sessions
  get '/' do
    erb(:index)
  end

  post '/names' do
    player_1 = Player.new(params[:player_1_name])
    player_2 = Player.new(params[:player_2_name])
    $game = Game.new(player_1, player_2)
    redirect '/play'
  end

  get '/play' do
    @game = $game
    erb :play
  end

  get '/attack1' do
    @game = $game
    @game.attack(@game.player_2)
    erb :attack1
  end

  post '/switch' do
    $game.switch
    redirect '/play'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
