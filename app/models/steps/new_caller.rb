module Steps
  class NewCaller
    def self.response options={}
      channel_id = options[:channel_id]
      address = options[:address]

      is_exist = ::CallLog.exist?(channel_id: channel_id, address: address) ? 1 : 0

      "{\"result\": \"#{is_exist}\"}"
    end

  end
end