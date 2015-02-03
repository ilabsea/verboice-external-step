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

# Rating
Step.create!(
  name: Step::ILO_RATING,
  display_name: 'Rating',
  description: 'Returning the code of rating',
  url: File.join(ENV['HOST'], '/steps/rating/manifest'),
  variables_attributes: [
    { name: 'result', display_name: 'Rating code', description: 'Rating code', kind: 'numeric', direction: 'outgoing' }
  ]
)

# ILO notify Rating
Step.create!(
  name: Step::NOTIFY_RATING,
  display_name: 'Notify Rating',
  description: 'Notify that caller was rating',
  url: File.join(ENV['HOST'], '/steps/notify_rating/manifest'),
  variables_attributes: [
    { name: 'result', display_name: 'Result', description: 'No response', kind: 'numeric', direction: 'outgoing' }
  ]
)
