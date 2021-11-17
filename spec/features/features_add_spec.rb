require 'pg'

describe Roma do
    feature 'adding a space to the website' do
        scenario 'user can add spaces' do
            ActiveUser.logout
            visit('/')
            PG.connect(dbname: 'airbnb_test')
            ActiveUser.signup('porkypig', 'oink', 'porky@looney.com')
            fill_in('name', with: 'porky palace' )
            fill_in('bedrooms', with: '17' )
            click_button('enter')
            expect(page).to have_content 'name: porky palace, bedroom: 17, host: porkypig'
        end
    end
end