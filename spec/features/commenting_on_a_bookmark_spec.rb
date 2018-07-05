
feature 'Commenting on a bookmark' do
  scenario 'anyone can comment on any bookmark' do
    bookmark = Bookmark.create(url: 'http://testexample.com', title: 'Test link')

    visit('/bookmarks')

    within "#bookmark-#{bookmark.id}" do
      click_link 'Comment'
    end

    fill_in(:text, with: 'This is a test comment on this bookmark.')
    click_button 'Submit'

    within "#bookmark-#{bookmark.id}" do
      expect(page).to have_content 'This is a test comment on this bookmark.'
    end
  end
end
