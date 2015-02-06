module Steps
  class NewCaller
    def self.response options={}
      channel_id = options[:channel_id]
      address = options[:address]

      begin
        BackEnd.authenticate_account!
        is_exist = ::CallLog.exist?(channel_id, address) ? 0 : 1
      rescue Service::ApiException => e
        is_exist = 'unauthorized'
      end

      "{\"result\": \"#{is_exist}\"}"
    end
  end
end