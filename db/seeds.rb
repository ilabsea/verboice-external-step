# Operator
Operator.destroy_all

Operator.create! name: 'mobitel', code: 1
Operator.create! name: 'smart', code: 2
Operator.create! name: 'beeline', code: 3
Operator.create! name: 'metfone', code: 4
Operator.create! name: 'qb', code: 5
Operator.create! name: 'cootel', code: 6
Operator.create! name: 'other', code: 0

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

    

