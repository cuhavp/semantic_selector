require '../Supports/api_client'
require '../Supports/data_client'

module Form

  def fill_sign_in_form
    puts 'Using machine learning to check elements'
    api_client = ApiClient.new()
    data_client = DataClient.new()
    data = data_client.pick_data_randomly()
    find_all(:xpath, '//input[not(@type="hidden")] | //select[not(@type="hidden")]').each do |input|
      html = input[:outerHTML]
      puts html
      topic = api_client.inference_html(html)
      case topic
        when 'email'
          puts 'fill in email'
          input.set(data[:email])
          sleep 5
        when 'password'
          puts 'fill in password'
          input.set(data[:password])
          sleep 5
        when 'firstName'
          puts 'fill in first name'
          input.set(data[:first_name])
          sleep 5
        when 'lastName'
          puts 'fill in last name'
          input.set(data[:last_name])
          sleep 5
        when 'address'
          puts 'fill in address'
          input.set(data[:last_name])
          sleep 5
        when 'phone'
          puts 'fill in phone'
          input.set(data[:address])
          sleep 5
        when 'postalCode'
          puts 'fill in postal code'
          input.set(data[:address])
          sleep 5
      end
      # sleep 60
    end
    # click_button('SIGN IN')
  end

  def fill_sign_up_form
#TODO:
  end

  def fill_payment_form
#TODO:
  end

  def fill_shipping_address_form
#TODO:
  end
end
