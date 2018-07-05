feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do
    bookmark = Bookmark.create(url: 'http://testexample.com', title: 'Test bookmark')
    visit('/bookmarks')

    expect(page).to have_content "Test Bookmarks"

  end
end
