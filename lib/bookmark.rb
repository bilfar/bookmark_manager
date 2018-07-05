# require_relative './database_connection'
require 'pg'
require 'uri'



class Bookmark
  attr_reader :id, :url, :title

  def initialize(id, url, title)
    @id  = id
    @url = url
    @title = title
  end


  def self.all
    if ENV['ENVIRONMENT'] = 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }
  end

  #
  # def self.all
  #     result = DatabaseConnection.query("SELECT * FROM links")
  #     result.map { |link| Link.new(link['id'], link['url'], link['title']) }
  #   end


  def self.create(options)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    return false unless is_url?(options[:url])

      result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{options[:url]}', '#{options[:title]}') RETURNING id, url, title")
      Bookmark.new(result[0]['id'], result[0]['url'], result[0]['title'])
  end

#
#   def self.create(options)
#     return false unless is_url?(options[:url])
# +    result = DatabaseConnection.query("INSERT INTO links (url, title) VALUES('#{options[:url]}', '#{options[:title]}') RETURNING id, url, title")
# +    Link.new(result[0]['id'], result[0]['url'], result[0]['title'])
#   end


    def self.delete(id)
      connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
      # DatabaseConnection.query("DELETE FROM links WHERE id = #{id}")
    end


    def self.update(id, options)
      DatabaseConnection.query("UPDATE bookmarks SET url = '#{options[:url]}', title = '#{options[:title]}' WHERE id = '#{id}'")
    end



    def self.find(id)
       result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
       result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }.first
     end

     def comments
       result = DatabaseConnection.query("SELECT * FROM comments WHERE bookmark_id = #{@id}")
       result.map { |comment| Comment.new(comment['id'], comment['text']) }
     end

    # def ==(other)
    #   @id == other.id
    # end

    private

    def self.is_url?(url)
      url =~ /\A#{URI::regexp(['http', 'https'])}\z/
    end

end
