class Service::Authentication
  def initialize email, password
    @email = email
    @password = password
  end

  def login!
    url = Instance.default.end_point + "/auth"
    response = Typhoeus::Request.post(url , body: {account: {email: @email, password: @password} }, headers: {"Accept" => "application/json"} )

    if response.success?
      @@success = true
      Service::Account.new(JSON.parse(response.body, symbolize_names: true))
    else
      @@success = false
      if response.code == 401 
        raise Service::ApiException.new('Unauthorized')
      elsif response.code == 404
        raise Service::ApiException.new('Page not found')
      end
    end
  end

  def success?
    @@success
  end
end
