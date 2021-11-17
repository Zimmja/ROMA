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
    p ENV['ENVIRONMENT']
    @username = ActiveUser.username
    @spaces = Space.all_objects
    erb(:index)
  end

  #get '/spaces' do
  #  p ENV
  #  @spaces = Spaces[blah_user_id_blah].all #work in progress
  #  erb :'spaces'
  #end

 # post '/addspace' do
 #   p params[:name]
 #   p params[:fk_user]
 #   Spaces.create(title: params[:title], url: params[:url])
 #   redirect '/spaces'
 # end

  post '/add' do
    Space.create(ActiveUser.id, params[:name], params[:bedrooms])
    redirect to '/'
  end
  
  # start the server if ruby file executed directly
 # run! if app_file == $0
end