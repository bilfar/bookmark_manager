require 'pg'
# require 'database_connection'
require 'uri'

class Bookmark
  attr_reader :id, :url

  def initialize(id, url)
    @id  = id
    @url = url
  end

  def ==(other)
    @id == other.id
  end

  def self.all
    if ENV['ENVIRONMENT'] = 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    result = connection.exec("SELECT * FROM bookmarks")
    result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url']) }
  end


  def self.create(options)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    return false unless is_url?(options[:url])

      result = connection.exec("INSERT INTO bookmarks (url) VALUES('#{options[:url]}') RETURNING id, url")
      Bookmark.new(result.first['id'], result.first['url'])
  end

  def self.delete(id)
  connection.exec("DELETE FROM bookmarks WHERE id = #{id}")
end

def self.update(id, options)
  DatabaseConnection.query("UPDATE bookmarks SET url = '#{options[:url]}', title = '#{options[:title]}' WHERE id = '#{id}'")
end

def self.find(id)
   result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id}")
   result.map { |bookmark| Bookmark.new(bookmark['id'], bookmark['url'], bookmark['title']) }.first
 end

# connection = PG.connect(dbname: 'bookmark_manager_test')
# connection.exec("UPDATE bookmarks SET url = '#{params['url']}', title = '#{params['title']}' WHERE id = '#{params['id']}'")

  private

  def self.is_url?(url)
    url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  end

end
