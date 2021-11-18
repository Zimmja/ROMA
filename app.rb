# frozen_string_literal: true
# Empty file
require 'sinatra/base'
require 'sinatra/reloader'
require './lib/activeuser'
require './lib/spaces'
require './lib/guests'

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

  get '/login/host' do
    @host_login = true
    erb(:login)
  end

  get '/login/guest' do
    erb(:login)
  end

  get '/signup/host' do
    @new_host = true
    erb(:signup)
  end

  get '/signup/guest' do
    erb(:signup)
  end

  get '/logout' do
    ActiveUser.logout
    redirect to '/'
  end

  post '/login/host/new' do
    ActiveUser.request_login(params[:username], params[:pwd])
    redirect to '/host/spaces'
  end

  post '/login/guest/new' do
    Guest.request_login(params[:username], params[:pwd])
    redirect to '/'
  end

  post '/signup/host/new' do
    ActiveUser.signup(params[:username], params[:pwd], params[:email])
    @username = params[:username]
    redirect to '/spaces'
  end 

  post '/signup/guest/new' do
    Guest.signup(params[:username], params[:pwd], params[:email])
    @username = params[:username]
    redirect to '/'
  end 

  get '/host/spaces' do
    @username = ActiveUser.username
    @spaces = Space.all_objects
    erb(:spaces)
  end

 # post '/addspace' do
 #   p params[:name]
 #   p params[:fk_user]
 #   Spaces.create(title: params[:title], url: params[:url])
 #   redirect '/
 # end

  post '/host/spaces/add' do
    Space.create(ActiveUser.id, params[:name], params[:bedrooms])
    redirect to '/host/spaces'
  end
  
  # start the server if ruby file executed directly
  # run! #if app_file == $0
end