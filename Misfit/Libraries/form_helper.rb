require '../Supports/api_client'
require '../Supports/data_client'

module Form
  def fill_sign_in_form
    puts '****************************************'
    puts 'Using machine learning to check elements'
    puts '****************************************'
    api_client = ApiClient.new()
    data_client = DataClient.new()
    data = data_client.pick_data_randomly()
    find_all(:xpath, '//input[not(@type="hidden")] | //select[not(@type="hidden")]').each do |input|
      html = input[:outerHTML]
      topic = api_client.inference_html(html)
      case topic
      when 'email'
        puts '[ML] fill in email with : ' + data[:email]
        input.set(data[:email])
      when 'password'
        puts '[ML] fill in password with : ' + data[:password]
        input.set(data[:password])
      when 'firstName'
        puts '[ML] fill in first name with : ' + data[:first_name]
        input.set(data[:first_name])
      when 'lastName'
        puts '[ML] fill in last name with : ' + data[:last_name]
        input.set(data[:last_name])

      when 'address'
        puts '[ML] fill in address with : ' + data[:address]
        input.set(data[:address])

      when 'phone'
        puts '[ML] fill in phone with : ' + data[:phone]
        input.set(data[:phone])

      when 'postalCode'
        puts '[ML] fill in postal code with : ' + data[:postal_code]
        input.set(data[:postal_code])

      end
      sleep 5
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
