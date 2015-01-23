require "rails_helper"

describe Tel, :type => :model do
  context "area code" do
    it { expect(Tel.new('012999999').area_code).to eq('12') }
    it { expect(Tel.new('85512999999').area_code).to eq('12') }
    it { expect(Tel.new('+85512999999').area_code).to eq('12') }
    it { expect(Tel.new('855012999999').area_code).to eq('12') }
    it { expect(Tel.new('+855012999999').area_code).to eq('12') }

    it { expect(Tel.new('010999999').area_code).to eq('10') }
    it { expect(Tel.new('85510999999').area_code).to eq('10') }
    it { expect(Tel.new('+85510999999').area_code).to eq('10') }
    it { expect(Tel.new('855010999999').area_code).to eq('10') }
    it { expect(Tel.new('+855010999999').area_code).to eq('10') }

    it { expect(Tel.new('1109999999').area_code).to eq(nil) }
    it { expect(Tel.new('+1109999999').area_code).to eq(nil) }
  end
end
