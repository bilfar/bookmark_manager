require 'bookmark'

describe Bookmark do
  before(:each) do
    @bookmark = Bookmark.create(url: 'http://www.testlink.com', title: 'Test bookmark')
  end

describe 'Database functions' do
  describe '.all' do
    it 'returns all bookmarks in an bookmark instance' do
      bookmarks = Bookmark.all
      urls = bookmarks.map(&:url)

      expect(urls).to include('http://www.testlink.com')

    end
  end


  describe '.create' do
    it 'creates a new bookmark' do
      expect(bookmark.id).not_to be_nil
  end

    it 'does not create a new bookmark if the url is not valid' do
      bookmark = Bookmark.create(url: 'not a real bootmark')

      expect(bookmark).to be false
  end
end


  describe '.delete' do
    it 'deletes a bookmark' do
      Bookmark.delete(@bookmark.id)

      bookmarks = Bookmark.all
      urls = bookmarks.map(&:url)

      expect(urls).not_to include "http://www.testlink.com"
    end
  end


  describe '.update' do
    it 'updates a bookmark' do
      Bookmark.update(@bookmark.id, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

      bookmarks = Bookmark.all
      urls = bookmarks.map(&:url)
      titles = bookmarks.map(&:title)

      expect(urls).not_to include "http://www.testlink.com"
      expect(titles).not_to include "Test Link"
      expect(urls).to include "http://www.snakersacademy.com"
      expect(titles).to include "Snakers Academy"
    end
  end


  describe '.find' do
    it 'finds a bookmark' do
      bookmark = Bookmark.find(@bookmark.id)

      expect(bookmark.url).to eq "http://www.testlink.com"
      expect(bookmark.title).to eq "Test Link"
    end
  end
end

  describe '#comments' do
      it 'returns all comments with a bookmark_id equal to this bookmark ID' do
        comment = Comment.create(bookmark_id: @bookmark.id, text: 'My test comment')

        expect(@bookmark.comments.map(&:id)).to include comment.id
      end
    end
end
