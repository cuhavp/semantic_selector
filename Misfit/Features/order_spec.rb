require '../Configuration/spec_helper'
require '../Supports/api_client'
require '../Supports/data_client'

feature 'Order a Command watch' do

  background do
    visit '/products/misfit-command?color=jet-and-silver&straps=black-sport-strap'
    page.driver.browser.manage.window.maximize
  end

  scenario 'As Registered user',:story => "Order a watch", :severity => :critical, :testId => 99 do
    # click_button('Add to Cart')
    visit('/webapp/wcs/stores/servlet/LoginRegisterView?storeId=37082&langId=-1&catalogId=26505#login')
    # click_button('Checkout')
    fill_sign_in_form()
  end

  # scenario 'As a Guest',:story => "Order a watch", :severity => :critical, :testId => 69 do
  #   click_button('Add to Cart')
  #   visit('/checkout/cart/')
  #   click_button('Checkout')
  #   click_button('Checkout as guest')
  #   fill_sign_in_form()
  # end
end
