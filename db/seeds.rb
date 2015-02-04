operators = [ {name: 'mobitel', code: 1},
              {name: 'smart', code: 2},
              {name: 'beeline', code: 3},
              {name: 'metfone', code: 4},
              {name: 'qb', code: 5},
              {name: 'cootel', code: 6},
              {name: 'other', code: 0}]

operators.each do |attrs|
  operator = Operator.where(name: attrs[:name]).first_or_initialize
  operator.update_attributes(attrs)
end

Step.destroy_all

# Detect Mobile Operator
Step.create!(
  name: Step::DETECT_MOBILE_OPERATOR,
  display_name: 'Detect Mobile Operator',
  description: 'Detect Mobile Operator',
  url: File.join(ENV['HOST'], '/steps/detect_mobile_operator/manifest'),
  variables_attributes: [
    { name: 'result', display_name: 'Mobile operator code', description: 'The mobile operator code', kind: 'numeric', direction: 'outgoing' }
  ]
)

# Date
Step.create!(
      name: Step::DATE,
      display_name: 'Date',
      description: 'Returning the current date',
      url: File.join(ENV['HOST'], '/steps/date/manifest'),
      variables_attributes: [
        { name: 'unit', display_name: 'Date unit', description: 'Unit of date(day/week/month/year)', kind: 'date_type', direction: 'incoming' },
        { name: 'value', display_name: 'Value', description: 'Number of unit(day/week/month/year) ago', kind: 'numeric', direction: 'incoming' },
        { name: 'result', display_name: 'Date', description: 'Current datetime', kind: 'text', direction: 'outgoing' }
      ]
    )

# Period rating
Step.create!(
  name: Step::PERIOD_RATING,
  display_name: 'Period Rating',
  description: 'This external step is used for detecting if a call is done within a period and the number has not rate in the period and return the code of the period. 
                In case of a call period does not match or the number already provided the rating in the period, it will return -1',
  url: File.join(ENV['HOST'], "/steps/#{Step::PERIOD_RATING}/manifest"),
  variables_attributes: [
    { name: 'result', display_name: 'Rating code', description: 'Return code if call period matches and the number has not rate in the period. <br/>
Return -1 if call period does not match or the number provided the rating in the period already.', kind: 'numeric', direction: 'outgoing' }
  ]
)

# Notify period rating
Step.create!(
  name: Step::STORE_PERIOD_RATING,
  display_name: 'Store Period Rating',
  description: 'This external step is used for saving the number that provide the rating within the period',
  url: File.join(ENV['HOST'], "/steps/#{Step::STORE_PERIOD_RATING}/manifest"),
  variables_attributes: [
    { name: 'result', display_name: 'Result', description: '', kind: 'numeric', direction: 'outgoing' }
  ]
)

Step.create!(
  name: Step::NEW_CALLER,
  display_name: 'New Caller',
  description: 'This external step is used to detect if a calling number is a new number',
  url: File.join(ENV['HOST'], "/steps/#{Step::NEW_CALLER}/manifest"),
  variables_attributes: [
    {
      name: 'result', display_name: 'Result', 
      description: 'return 1 if it is a new number <br/> return 0 if it is not new number',
      kind: 'numeric', direction: 'outgoing'
    }
  ]
)
