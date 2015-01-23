require "rails_helper"

describe Xml, :type => :model do
  context 'steps' do
    it { expect(Xml.steps.length).to eq(2) }
    it { expect(Xml.steps.first).to be_kind_of(Xml::StepNode) }
    it { expect(Xml.steps.last).to be_kind_of(Xml::StepNode) }
  end

end
