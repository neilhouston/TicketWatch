require 'rubygems'
require 'sinatra'
#require 'sinatra-helpers/haml/partials'
require 'haml'
#require 'lib/models'


get '/about' do
	haml :about
end

get '/' do
	haml :home
end

get '/error' do
	haml :error
end

not_found do
	haml :not_found
end

