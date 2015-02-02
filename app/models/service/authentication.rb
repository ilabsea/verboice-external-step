class Service::Authentication
  # must be matched with role setting in Verboice
  VERBOICE_ADMIN_ROLE = 1
  VERBOICE_USER_ROLE = 2

  def initialize email, password
    @email = email
    @password = password
  end

  def login!
      url = Instance.default.end_point + "/auth"
      response = Typhoeus::Request.post(url , body: {account: {email: @email, password: @password} }, headers: {"Accept" => "application/json"} )

      if response.success?
        Service::Account.new(JSON.parse(response.body, symbolize_names: true))
      else
        if response.code == 401 
          raise Service::ApiException.new('Unauthorized')
        elsif response.code == 404
          raise Service::ApiException.new('Page not found')
        end
      end

  end
end
