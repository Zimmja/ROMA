
feature 'Sign-up' do
  scenario 'Users can sign-up' do
    visit('/')
    click_link('Sign up')
    fill_in 'username', with: 'Clint Barton'
    fill_in 'pwd', with: 'hawkeye'
    fill_in 'email', with: 'clint@thenest.com'
    click_button('Submit')
    expect(page).to have_content 'user: Clint Barton'
  end
end

feature 'Login' do
  scenario 'Users can sign-up' do
    login_with_tony
    expect(page).to have_content 'user: Tony Stark'
  end
end
 