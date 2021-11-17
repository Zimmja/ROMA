# frozen_string_literal: true
# Empty file
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/activeuser'
require './lib/spaces'


class Roma < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end


  get '/' do
    p ENV
    erb(:index)
  end

  get '/signup' do
    erb(:signup)
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
  
  # start the server if ruby file executed directly
 # run! if app_file == $0
end