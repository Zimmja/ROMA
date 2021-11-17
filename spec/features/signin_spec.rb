feature 'sign-in' do
  scenario 'Creates a User to sign in ' do 
    connection = PG.connect(dbname: 'airbnb_test')
    visit('/')
    fill_in 'username', with: 'Mr Sungawugs'
    fill_in 'password', with: 'Zippydippy'
    click_button('Submit')
    expect(page).to have_content 'Welcome Mr Snugawugs'
  end
end
 