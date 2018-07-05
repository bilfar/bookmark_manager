require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark'
require './lib/comment'
require 'uri'
# require './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash


  get '/' do
    redirect('/bookmarks')
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :"bookmarks/index"
  end

  get '/bookmarks/new' do
    erb :"bookmarks/new"
  end

  post '/bookmarks' do
    bookmark = Bookmark.create(url: params['url'], title: prams['title'])

    flash[:notice] = "You must submit a valid URL." unless bookmark
    redirect('/bookmarks')
  end


  post '/bookmarks/:id/delete' do
    Bookmark.delete(params['id'])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(params['id'])
    erb :"bookmarks/edit"
  end


  post '/bookmarks/:id/update' do
    Bookmark(update(params['id'], params))
    redirect('/')
  end


  get '/bookmarks/:id/comments/new' do
    @bookmark = Bookmark.find(params['id'])
    erb :"comments/new"
  end

    post '/bookmarks/:id/comments' do
      comment = Comment.create(bookmark_id: params['id'], text: params['text'])
      redirect('/bookmarks')
    end

  run! if app_file == $0

end
