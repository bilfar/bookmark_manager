
feature 'Deleting a bookmark' do
  scenario 'A user can delete a bookmark' do
    Bookmark.create(url: 'http://makersacademy.com', title: 'Makers Academy')
    visit('/bookmarks')

    within '#bookmark-1' do
      click_button 'Delete'
    end

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content 'Makers Academy'
  end
end
