class CallLog
  def self.exist?(channel_id, address)
    Service::CallLog.fetch_by(channel_id, address).count > 1
  end
end
