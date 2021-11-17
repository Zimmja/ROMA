def login_with_tony
  visit('/')
  click_link('Login')
  fill_in 'username', with: 'Tony Stark'
  fill_in 'pwd', with: 'ironman'
  click_button('Submit')
end

def tony_create_space
  visit('/')
  fill_in 'name', with: 'cave'
  fill_in 'bedrooms', with: '2'
  click_button('add_space')
end