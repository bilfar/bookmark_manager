require 'sinatra/base'
require './lib/bookmark'
require 'sinatra/flash'
require 'uri'
# require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :index
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL." unless Bookmark.create(url: params['url'])
    redirect('/bookmarks')
  end

  delete '/bookmarks/:id/delete' do
    Bookmark.delete(params['id'])
    redirect '/'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params['id'])
    erb :"bookmarks/edit"
  end



  get '/bookmarks/:id' do
    @bookmark_id = params['id']
    erb :"bookmarks/edit"
  end


patch '/bookmarks/:id' do
  Bookmark.update(params['id'], params)
  redirect('/bookmarks')
end


  run! if app_file == $0

end
