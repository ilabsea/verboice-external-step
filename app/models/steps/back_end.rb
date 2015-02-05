module Steps
  class BackEnd
    def self.authenticate_account!
      @@authentication = Service::Authentication.new(ENV['EMAIL'], ENV['SECRET'])
      account = @@authentication.login!

      if(@@authentication.success?)
        ActiveApi.init_auth(account)
      end
    end

    def self.authenticated?
      @@authentication.success?
    end
  end
end
