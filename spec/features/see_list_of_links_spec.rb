feature 'Viewing links' do
  scenario 'A user can see links' do
    visit('/links')
    expect(page).to have_content "Facebook"
  end
end

feature 'Wants to submit a new link' do
  scenario 'A user can go to the other page to add a link' do
    visit('/links')
    click_button("Add new link")
    expect(page).to have_content("Add new links here!")
  end
end

feature 'Wants to delete a bookmark' do
  scenario 'A user can delete a link from the bookmark list' do
    visit('/links')
    within("//li[@id='1']") do
      click_button("Delete")
    end
    expect(page).not_to have_content("Makers Academy")
  end
end

feature 'Wants to update a bookmark' do
  scenario 'A user can update a link from the bookmark list' do
    visit('/links')
    within("//li[@id='1']") do
      click_button("Update")
    end
    fill_in 'update', with: "http://www.reddit.com"
    click_button("Update")
    expect(page).not_to have_content("Makers Academy")
    expect(page).to have_content("Reddit")
  end
end
