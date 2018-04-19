require "json"
require "selenium-webdriver"
require "rspec"

require '../Configuration/spec_helper'

describe 'TC2' do
  it "test_t_c2" do
    visit "https://misfit.com/"
    find(:xpath, "//span[@onclick=\"window.location.href='https://misfit.com/products/misfit-command'\"]").click
    find(:id, "color-button-silver-and-white").click

    find(:id, "qty").send_keys "2"
    find(:id, "qty").click
    find(:id, "add-to-cart").click
    find(:link, "Checkout").click
    find(:id, "onepage-guest-register-button").click
    find(:xpath, "(//button[@type='button'])[2]").click
  end
end
