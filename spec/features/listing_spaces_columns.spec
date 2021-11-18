feature 'allows the user to view all spaces against a particular column ' do
  scenario 'the user selects prices-per-night' do 
    connection = PG.connect(dbname: 'airbnb_test')
    visit('/spaces')
    fill_in 'username', with: 'Mr Sungawugs'
    fill_in 'password', with: 'Zippydippy'
    fill_in 'email', with: "snugawugs@kittens"
    click_button('Submit')
    expect(page).to have_content 'Welcome Mr Snugawugs'
  end


  scenario 'the user selects '
end
 