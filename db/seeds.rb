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
  description: 'Returning the code of period rating',
  url: File.join(ENV['HOST'], "/steps/#{Step::PERIOD_RATING}/manifest"),
  variables_attributes: [
    { name: 'result', display_name: 'Rating code', description: 'Rating code', kind: 'numeric', direction: 'outgoing' }
  ]
)

# Notify period rating
Step.create!(
  name: Step::STORE_PERIOD_RATING,
  display_name: 'Store Period Rating',
  description: 'Store that caller was rating',
  url: File.join(ENV['HOST'], "/steps/#{Step::STORE_PERIOD_RATING}/manifest"),
  variables_attributes: [
    { name: 'result', display_name: 'Result', description: '', kind: 'numeric', direction: 'outgoing' }
  ]
)
