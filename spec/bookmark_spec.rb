require 'bookmark'

describe Bookmark do
  describe '.all' do
    it 'returns all bookmarks in an array' do

           bookmark_1 = Bookmark.create(url: "http://makersacademy.com")
           bookmark_2 = Bookmark.create(url: "http://destroyallsoftware.com")
           bookmark_3 = Bookmark.create(url: "http://google.com")

      expected_bookmarks = [
        bookmark_1,
        bookmark_2,
        bookmark_3
      ]

      expect(Bookmark.all).to eq expected_bookmarks

    end
  end

  describe '.create' do
    # it 'creates a new bookmark' do
    #   bookmark = Bookmark.create(url: 'http://www.testbookmark.com')
    #
    #   expect(Bookmark.all).to include bookmark
    # end

    it 'does not create a new bookmark if the url is not valid' do
      Bookmark.create(url: 'not a real bookmark')

      expect(Bookmark.all).not_to include 'not a real bookmark'
    end
  end

  describe '#==' do
    it 'two Bookmarks are equal if their IDs match' do
      bookmark_1 = Bookmark.new(1, url: 'http://testbookmark.com')
      bookmark_2 = Bookmark.new(1, url: 'http://testbookmark.com')

      expect(bookmark_1).to eq bookmark_2
  end
end


describe '.delete' do
  it 'deletes a bookmark' do
    Bookmark.create("http://www.makersacademy.com")
    Bookmark.delete(1)

    bookmarks = Bookmark.all
    urls = bookmarks.map(&:url)

    expect(urls).not_to include "http://www.makersacademy.com"
  end
end


describe '.update' do
  it 'updates a bookmark' do
    Bookmark.create(url: 'http://www.makersacademy.com')
    Bookmark.update(1, url: 'http://www.snakersacademy.com', title: 'Snakers Academy')

    bookmarks = Bookmark.all
    urls = bookmarks.map(&:url)
    titles = bookmarks.map(&:title)

    expect(urls).not_to include "http://www.makersacademy.com"
    expect(titles).not_to include "Makers Academy"
    expect(urls).to include "http://www.snakersacademy.com"
    expect(titles).to include "Snakers Academy"
  end
end



describe '.find' do
  it 'finds a bookmark' do
    bookmark = Bookmark.find(1)

    expect(bookmark.url).to eq "http://www.makersacademy.com"
    expect(bookmark.title).to eq "Makers Academy"
  end
end

end
