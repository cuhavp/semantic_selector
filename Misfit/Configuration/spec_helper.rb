require 'capybara'
require 'rspec'
require 'capybara/dsl'
require 'capybara/rspec'
require 'rspec/expectations'
require 'selenium-webdriver'

require 'date'


require 'allure-rspec'

require '../Supports/api_client'
require '../Supports/data_client'
require '../Libraries/form_helper'

include RSpec::Matchers
Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = 'https://www.skagen.com' # change url
end

RSpec.configure do |config|
  config.include Capybara::DSL
  # config.include User_Data
  config.include Form
  config.include AllureRSpec::Adaptor

  #Capture screenshot when failed
  config.after(:each) do |example|
    if (example.exception != nil)
      take_screenshot(example)
    end

  end

  config.after(:all) do
    # page.quit
  end

end


AllureRSpec.configure do |c|
  c.output_dir = "./../Reports" # default: gen/allure-results
  c.clean_dir = true # clean the output directory first? (default: true)
  c.logging_level = Logger::DEBUG # logging level (default: DEBUG)
end

def take_screenshot(example)
  meta = example.metadata
  filename = File.basename(meta[:file_path])
  line_number = meta[:line_number]
  current_time = DateTime.now
  time = current_time.strftime "%d_%m_%Y_%H_%M"
  screenshot_name = "screenshot-#{filename}-#{line_number}-#{time}.png"
  screenshot_path = File.join("./../Reports/Screenshot/", screenshot_name)
  page.save_screenshot(screenshot_path)

  puts meta[:full_description] + "\n  Screenshot: #{screenshot_path}"
end
