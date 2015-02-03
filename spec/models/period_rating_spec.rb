require 'rails_helper'

RSpec.describe PeriodRating, :type => :model do
	before(:each) do
		@step = create(:step, name: "rating", display_name: "Rating", description: "Rating")
	end

	describe 'create' do
		context 'parse date string to date' do
			it {
				rating = create(:period_rating, client_from_date: '01/01/2015', client_to_date: '02/01/2015', code: 1, step_id: @step.id)
				expect(rating.from_date.to_string).to eq('01/01/2015')
				expect(rating.to_date.to_string).to eq('02/01/2015')
			}
		end

		context 'unique date range' do
			context 'valid' do
				it { expect(create(:period_rating, client_from_date: '01/01/2015', client_to_date: '02/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating) }
			end

			context 'ignore when date is already existed' do
				it {
					expect(create(:period_rating, client_from_date: '01/01/2015', client_to_date: '02/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating)
					expect { create(:period_rating, client_from_date: '01/01/2015', client_to_date: '02/01/2015', code: 2, step_id: @step.id) }.to raise_error
				}
			end
		end

		context 'unique code' do
			it {
				expect(create(:period_rating, client_from_date: '01/01/2015', client_to_date: '02/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating)
					expect { create(:period_rating, client_from_date: '03/01/2015', client_to_date: '04/01/2015', code: 1, step_id: @step.id) }.to raise_error
			}
		end
	end

  describe '.exist?' do
  	before(:each) do
	    @rating = create(:period_rating, client_from_date: '01/01/2015', client_to_date: '02/01/2015', code: 1, numbers: ['12999999'], step_id: @step.id)
	  end	

	  context 'it should return true when phone number and date is exist in the range' do
	  	it { expect(@rating.exist?(tel: Tel.new('012999999'), date: Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(tel: Tel.new('85512999999'), date: Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(tel: Tel.new('855012999999'), date: Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(tel: Tel.new('+85512999999'), date: Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(tel: Tel.new('+855012999999'), date: Date.parse('2015-01-01'))).to be(true) }
	  end

	  context 'it should return false when date is not exist in the range' do
	  	it { expect(@rating.exist?(tel: Tel.new('012999999'), date: Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(tel: Tel.new('85512999999'), date: Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(tel: Tel.new('855012999999'), date: Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(tel: Tel.new('+85512999999'), date: Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(tel: Tel.new('+855012999999'), date: Date.parse('2014-12-31'))).to be(false) }
	  end
  end

end
