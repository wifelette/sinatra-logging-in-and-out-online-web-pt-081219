require_relative '../../config/environment'
require_relative '../helpers/helpers'

class ApplicationController < Sinatra::Base
  helpers Helpers

  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  post '/login' do
    @user = User.find_by(username: params[:username], password: params[:password])
    if @user.nil?
      erb :error
    else
      session[:user_id] = @user.id
      redirect to '/account'
    end
  end

  get '/account' do
    if @user = current_user(session)
      erb :account
    else
      erb :error
    end
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end

