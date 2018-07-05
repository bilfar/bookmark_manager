require 'comment'

RSpec.describe Comment do
  describe '.create' do
    it 'creates a new comment' do
      bookmark = Bookmark.create(url: 'http://www.testlink.com')
      comment = Comment.create(bookmark_id: bookmark.id, text: 'My comment here')

      expect(comment.id).not_to be_nil
    end
  end
end
