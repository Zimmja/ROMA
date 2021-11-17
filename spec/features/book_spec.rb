feature 'Make a booking' do
  scenario 'Logged in users can make a booking' do
    login_with_tony
    tony_create_space
    expect(page).to have_content 'the cave'
  end
end