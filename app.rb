require 'sinatra/base'
require 'sinatra/flash'
require './lib/link'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    @links = Link.all
    erb :index
  end

  get '/add_link' do
    erb :add_new_links
  end

  post '/add_link' do
    erb :add_new_links
  end

  post '/create_new_link' do
    begin
      Link.add_new_link(params[:new_link])
      redirect '/'
    rescue Exception => error
      flash[:notice] = error.message
    end
    redirect('/add_link')
  end

  post '/delete' do
    Link.delete(params[:id])
    redirect '/'
  end

  post '/update' do
    session[:id] = params[:id]
    redirect '/update'
  end

  get '/update' do
    erb :update
  end

  post '/updated' do
    Link.update(session[:id], params[:update])
    redirect '/'
  end

  run! if app_file == $0
end
