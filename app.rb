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
    @game = Game.create(player_1, player_2)
    redirect '/play'
  end

  get '/play' do
    @game = Game.instance
     if @game.player_1.dead? || @game.player_2.dead?
       erb :lose
     else
       erb :play
     end
  end

  get '/attack1' do
    @game = Game.instance
    @game.attack(@game.opponent)
    erb :attack1
  end

  post '/switch' do
    @game = Game.instance
    @game.switch
    redirect '/play'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
