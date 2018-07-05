# require_relative './database_connection'

class Comment
  attr_reader :id, :text

  def initialize(id, text)
    @id = id
    @text = text
  end

  def self.create(options)
    result = DatabaseConnection.query("INSERT INTO comments (bookmark_id, text) VALUES('#{options[:bookmark_id]}', '#{options[:text]}') RETURNING id, text")
    Comment.new(result[0]['id'], result[0]['text'])
  end
end
