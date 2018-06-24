require '../Configuration/spec_helper'
require '../Supports/api_client'
require '../Supports/data_client'

feature 'Create new user' do

  background do
    visit '/customer/account/create/'
  end

  scenario 'As a Guest',:story => "Order a watch", :severity => :critical, :testId => 69 do
    fill_sign_in_form()
  end
end
