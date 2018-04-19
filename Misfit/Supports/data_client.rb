require 'faraday'
require 'json'

class DataClient
  def initialize(host = 'https://my.api.mockaroo.com')
    @conn = Faraday.new(:url => host)
  end

  # this key limit 200 session per day
  def pick_data_randomly
    response = @conn.get do |req|
      req.url '/users.json?key=bac030d0'
    end

    if response.success?
      body = JSON.parse(response.body, {:symbolize_names => true})
    end
    return body
  end


end