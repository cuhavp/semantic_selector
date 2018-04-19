require '../Configuration/spec_helper'
require '../Supports/api_client'
require '../Supports/data_client'
require '../Supports/data_client'

feature 'Amazon' do

  background do
    visit 'https://www.amazon.com'
    # page.driver.browser.manage.window.maximize
  end

  scenario 'Search product' do
    data_client = DataClient.new()
    data = data_client.pick_data_randomly()
    fill_in 'field-keywords', :with => 'ferrari 584'
    find('#nav-search > form > div.nav-right > div > input').click
    page.has_text?("results for \"ferrari 584\"")
    find(:css, '#result_0 a.s-access-detail-page').click
    page.has_text?('Back to search results')
    find(:id, 'add-to-cart-button').click
    # find('#warrantyModalBtnAtc > span > input').click
    if page.has_css?('#warrantyModalBtnAtc > span > input')
      find('#warrantyModalBtnAtc > span > input').click
    end
    page.has_text?('Added to Cart')
    find(:id, 'hlb-ptc-btn-native').click

    # fill_in 'email', :with => data[:email]
    # fill_in 'password', :with => data[:password]
    fill_sign_in_form()
    find(:id, 'signInSubmit').click

  end
end