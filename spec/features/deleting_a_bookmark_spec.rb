
feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmark' do
    bookmark = Bookmark.create(url: 'http://testexample.com', title: 'Test bookmark')
    visit('/bookmarks')

    within "#bookmark-#{bookmark.id}" do
      click_button 'Delete'
    end

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content 'Makers Academy'
  end
end
