# frozen_string_literal: true
# Empty file
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/activeuser'
require './lib/spaces'

class Roma < Sinatra::Base
  # set :public, 'public'
  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    p ENV['ENVIRONMENT']
    @username = ActiveUser.username
    @spaces = Space.all_objects
    erb(:index)
  end

  get '/signup' do
    erb(:signup)
  end

  get '/logout' do
    ActiveUser.logout
    redirect to '/'
  end

  post '/signup/new' do
    ActiveUser.signup(params[:username], params[:pwd], params[:email])
    @username = params[:username]
    redirect to '/spaces'
  end 


  get '/spaces' do
    @username = ActiveUser.username
    erb(:spaces)
  end

 # post '/addspace' do
 #   p params[:name]
 #   p params[:fk_user]
 #   Spaces.create(title: params[:title], url: params[:url])
 #   redirect '/
 # end

  post '/add' do
    Space.create(ActiveUser.id, params[:name], params[:bedrooms])
    redirect to '/'
  end
  
  # start the server if ruby file executed directly
 # run! if app_file == $0
end