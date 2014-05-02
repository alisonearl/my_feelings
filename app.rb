require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require 'rack-flash'
require './models.rb'


set :database, "sqlite3:///database.sqlite3"
set :sessions, true
enable :sessions
use Rack::Flash, sweep: true


get "/signup" do
	erb :signup
end


post "/create-user" do
	#this will catch the sign up information
	# as params[:user]
	
	@user = User.create( params[:user] )
	if @user
		session[:user_id] = @user.user_id
		flash[:notice] = "Signed up successfully"

	else
		flash[:notice] = "Failed to signup. Please check your info"
		redirect "/signup"
	end
end