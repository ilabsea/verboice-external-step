class CallLog
  def self.exist?(channel_id:, address:)
    Service::CallLog.fetch_by(channel_id: channel_id, address: address).count > 1
  end
end
