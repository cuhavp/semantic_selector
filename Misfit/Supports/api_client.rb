require 'faraday'
require 'json'

class ApiClient
  def initialize(host="http://localhost:5000")
    @conn = Faraday.new(:url => host)
  end

  def inference_html(html)
    puts( '[ML] Check element : ' +html)
    response = @conn.post do |req|
      req.url '/api/inference'
      req.headers['Content-Type'] = 'application/json'
      req.body = JSON.generate({html: html})
    end
    result = 'unknown'
    if response.success?
      body = JSON.parse(response.body, {:symbolize_names => true})
      result = body[:topic]
      puts('[ML] Detect topic : '+result) 
    end
    return result
  end
end
