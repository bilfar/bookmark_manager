
feature 'Updating a bookmark' do
  scenario 'A user can update a bookmark' do
    bookmark = Bookmark.create(url: 'http://testexample.com', title: 'Test bookmark' )

    visit("/bookmarks/#{bookmark.id}/edit")

    fill_in('url', with: "http://www.snakersacademy.com")
    fill_in('title', with: "Snakers Academy")
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content 'Test bookmark'
    expect(page).to have_content 'Snakers Academy'
  end
end
