class Service::CallLog < ActiveApi
  attribute :id
  attribute :address

  def self.fetch_by(channel_id:, address:)
    where(channel_id: channel_id, address: address)
  end

end
