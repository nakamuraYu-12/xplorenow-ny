class MapQuery
  def initialize(event_param)
    @event_param = event_param
  end

  def uri
    address = URI.encode_www_form({address: @event_param})
    URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{address}&key=#{ENV["GOOGLE_API_KEY"]}")
  end

  def result
    api_response = Net::HTTP.get_response(uri)
    response_body = JSON.parse(api_response.body)
    response_body["results"][0]["geometry"]["location"]
  end
end