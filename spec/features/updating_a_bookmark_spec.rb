
feature 'Updating a bookmark' do
  scenario 'A user can update a bookmark' do
    visit('/bookmarks/1/edit')

    fill_in('url', with: "http://www.snakersacademy.com")
    fill_in('title', with: "Snakers Academy")
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content 'Makers Academy'
    expect(page).to have_content 'Snakers Academy'
  end
end
