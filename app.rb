require 'sinatra/base'
require 'sinatra/flash'
require './lib/link'
require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all
    erb :index
  end

  get '/links/add_link' do
    erb :add_new_links
  end

  post '/links/add_link' do
    redirect '/links/add_link'
  end

  post '/links/create_new_link' do
    begin
      Link.add_new_link(params[:new_link])
      redirect '/links'
    rescue Exception => error
      flash[:notice] = error.message
    end
    redirect('/links/add_link')
  end

  post '/links/:id/delete' do
    Link.delete(params[:id])
    redirect '/links'
  end

  post '/links/:id/update' do
    session[:id] = params[:id]
    redirect '/links/:id/update'
  end

  get '/links/:id/update' do
    @session_id = session[:id] 
    erb :update
  end

  post '/links/:id/updated' do
    Link.update(session[:id], params[:update])
    redirect '/links'
  end

  run! if app_file == $0
end
