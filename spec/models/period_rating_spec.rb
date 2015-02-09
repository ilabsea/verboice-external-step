require 'rails_helper'

RSpec.describe PeriodRating, :type => :model do
  before(:each) do
    @step = create(:step, name: "rating", display_name: "Rating", description: "Rating")
  end

  describe 'get code of' do
    before(:each) do
      create(:period_rating, from_date: '01/01/2015', to_date: '31/01/2015', numbers: ['12999999'], code: 1, step_id: @step.id)
    end

    context 'return -1 when the date is not matches period' do
			it { expect(PeriodRating.get_code_of Date.new(2015,2,1), Tel.new('012999999')).to eq(-1) }
    end

    context 'return -1 when the date is matches and caller is already rated' do
			it { expect(PeriodRating.get_code_of Date.new(2015,2,1), Tel.new('012999999')).to eq(-1) }
    end

    context 'return period code when the date is matches but caller is not yet rate' do
			it { expect(PeriodRating.get_code_of Date.new(2015,1,1), Tel.new('012999999')).to eq(-1) }
    end
  end

  describe 'create' do
    context 'parse date string to date' do
      it {
        rating = create(:period_rating, from_date: '01/01/2015', to_date: '02/01/2015', code: 1, step_id: @step.id)
        expect(rating.from_date.to_string).to eq('01/01/2015')
        expect(rating.to_date.to_string).to eq('02/01/2015')
      }
    end

    context 'from date must be less than to date' do
      it { expect { create(:period_rating, from_date: '31/01/2015', to_date: '01/01/2015', code: 2, step_id: @step.id) }.to raise_error }
    end

    context 'unique date range' do
      context 'valid' do
        it { expect(create(:period_rating, from_date: '01/01/2015', to_date: '02/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating) }
      end

      context 'ignore when from date in the past and to date in the range' do
        it {
          expect(create(:period_rating, from_date: '02/01/2015', to_date: '05/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating)
          expect { create(:period_rating, from_date: '01/01/2015', to_date: '03/01/2015', code: 2, step_id: @step.id) }.to raise_error
        }
      end

      context 'ignore when from date in the past and to date in the future' do
        it {
          expect(create(:period_rating, from_date: '02/01/2015', to_date: '05/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating)
          expect { create(:period_rating, from_date: '01/01/2015', to_date: '06/01/2015', code: 2, step_id: @step.id) }.to raise_error
        }
      end

      context 'ignore when from date is in range' do
        it {
          expect(create(:period_rating, from_date: '01/01/2015', to_date: '02/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating)
          expect { create(:period_rating, from_date: '01/01/2015', to_date: '03/01/2015', code: 2, step_id: @step.id) }.to raise_error
        }
      end
    end

    context 'unique code' do
      it {
        expect(create(:period_rating, from_date: '01/01/2015', to_date: '02/01/2015', code: 1, step_id: @step.id)).to be_kind_of(PeriodRating)
          expect { create(:period_rating, from_date: '03/01/2015', to_date: '04/01/2015', code: 1, step_id: @step.id) }.to raise_error
      }
    end
  end

  describe '.exist?' do
    before(:each) do
      @rating = create(:period_rating, from_date: '01/01/2015', to_date: '02/01/2015', code: 1, numbers: ['12999999'], step_id: @step.id)
    end 

    context 'it should return true when phone number and date is exist in the range' do
	  	it { expect(@rating.exist?(Tel.new('012999999'), Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(Tel.new('85512999999'), Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(Tel.new('855012999999'), Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(Tel.new('+85512999999'), Date.parse('2015-01-01'))).to be(true) }
	  	it { expect(@rating.exist?(Tel.new('+855012999999'), Date.parse('2015-01-01'))).to be(true) }
    end

    context 'it should return false when date is not exist in the range' do
	  	it { expect(@rating.exist?(Tel.new('012999999'), Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(Tel.new('85512999999'), Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(Tel.new('855012999999'), Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(Tel.new('+85512999999'), Date.parse('2014-12-31'))).to be(false) }
	  	it { expect(@rating.exist?(Tel.new('+855012999999'), Date.parse('2014-12-31'))).to be(false) }
    end
  end

end
