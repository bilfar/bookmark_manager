require 'pg'

feature 'Viewing bookmarks' do
  scenario 'A user can see bookmarks' do

        Bookmark.create(url: "http://makersacademy.com")
        Bookmark.create(url: "http://destroyallsoftware.com")
        Bookmark.create(url: "http://google.com")

    visit('/bookmarks')

    expect(page).to have_content 'http://makersacademy.com'
    expect(page).to have_content 'http://google.com'
    expect(page).to have_content 'http://destroyallsoftware.com'
  end
end
