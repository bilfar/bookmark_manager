
feature 'Commenting on a bookmark' do
  scenario 'anyone can comment on any bookmark' do
    visit('/bookmarks')

    within '#bookmark-1' do
      click_link 'Comment'
    end

    fill_in(:text, with: 'This is a test comment on this bookmark.')
    click_button 'Submit'

    within '#bookmark-1' do
      expect(page).to have_content 'This is a test comment on this bookmark.'
    end
  end
end 
