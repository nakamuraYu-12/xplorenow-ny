class MapQuery
  def initialize(event_param)
    @event_param = event_param
  end

  def uri
    address = URI.encode_www_form({ address: @event_param })
    URI.parse("https://maps.googleapis.com/maps/api/geocode/json?#{address}&key=#{ENV["GOOGLE_API_KEY"]}")
  end

  def result
    api_response = Net::HTTP.get_response(uri)
    response_body = JSON.parse(api_response.body)

    # 判定が長く読みづらいので、
    # return response_body.dig("results", 0, "geometry", "location")
    # とかいかがでしょう？？(無理そうならごめんなさい！！！)
    if response_body["results"].present? &&
        response_body["results"][0].present? &&
        response_body["results"][0]["geometry"].present? &&
        response_body["results"][0]["geometry"]["location"].present?
      response_body["results"][0]["geometry"]["location"]
    else
      nil
    end
  end
end
