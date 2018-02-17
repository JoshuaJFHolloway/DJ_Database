feature 'Add comments' do
  scenario 'User can add comments to a bookmark' do
    visit '/links'
    within("//li[@id='1']") do
      fill_in 'comment', with: "This is riveting, Mary!"
      click_button("Comment")
      expect(page).to have_content "This is riveting, Mary!"
    end

  end
end
