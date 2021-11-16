require 'pg'

describe Roma do
    feature 'adding a space to the website' do
        scenario 'user can add spaces' do
            visit('/')
            #add sign up process
            fill_in('name', with: 'porky palace' )
            fill_in('bedrooms', with: '17' )
            click_button('enter')
            expect(page).to have_content 'name: porky palace, bedroom: 17, host: porkypig'
        end
    end
end