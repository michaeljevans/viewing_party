require 'rails_helper'

RSpec.describe 'As a user,' do
  it 'I can visit welcome and see descrition' do
    visit '/'

    expect(page).to have_content('Welcome to the Party')
    expect(page).to have_button('Log In with Google')
  end
end
