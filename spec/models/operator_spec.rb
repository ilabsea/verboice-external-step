require 'rails_helper'

RSpec.describe Operator, :type => :model do
  before(:each) do
    create(:operator, name: 'mobitel', code: 1, prefixes: ["012", "017", "092", "089", "077", "078", "011", "099"])
    create(:operator, name: 'smart', code: 2, prefixes: ["010", "093", "086", "096"])
    create(:operator, name: 'beeline', code: 3, prefixes: ["090", "067", "068"])
    create(:operator, name: 'metfone', code: 4, prefixes: ["097", "088"])
    create(:operator, name: 'qb', code: 5, prefixes: ["013"])
    create(:operator, name: 'cootel', code: 6, prefixes: ["038"])
    create(:operator, name: 'other', code: 0, prefixes: [])
  end

  context "get" do
    it { expect(Operator.get(Tel.new('012999999').area_code)).not_to be(nil) }
    it { expect(Operator.get(Tel.new('85512999999').area_code)).not_to be(nil) }
    it { expect(Operator.get(Tel.new('+85512999999').area_code)).not_to be(nil) }

    it { expect(Operator.get(Tel.new('010999999').area_code)).not_to be(nil) }
    it { expect(Operator.get(Tel.new('85510999999').area_code)).not_to be(nil) }
    it { expect(Operator.get(Tel.new('+85510999999').area_code)).not_to be(nil) }

    it { expect(Operator.get(Tel.new('+1109999999').area_code)).to be(nil) }
  end
end
