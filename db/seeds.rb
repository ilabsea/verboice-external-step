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

steps = [
  {
    name: Step::DETECT_MOBILE_OPERATOR,
    display_name: 'Detect Mobile Operator',
    description: 'Detect Mobile Operator',
    url: File.join(ENV['HOST'], '/steps/detect_mobile_operator/manifest'),
    variables_attributes: [
      { name: 'result', display_name: 'Mobile operator code', description: 'The mobile operator code', kind: 'numeric', direction: 'outgoing' }
    ]
  },
  {
    name: Step::DATE,
    display_name: 'Date',
    description: 'Returning the current date',
    url: File.join(ENV['HOST'], '/steps/date/manifest'),
    variables_attributes: [
      { name: 'unit', display_name: 'Date unit', description: 'Unit of date(day/week/month/year)', kind: 'date_type', direction: 'incoming' },
      { name: 'value', display_name: 'Value', description: 'Number of unit(day/week/month/year) ago', kind: 'numeric', direction: 'incoming' },
      { name: 'result', display_name: 'Date', description: 'Current datetime', kind: 'text', direction: 'outgoing' }
    ]
  },
  {
    name: Step::PERIOD_RATING,
    display_name: 'Period Rating',
    description: 'This external step is used for checking if a call is within a rating period, and if the phone number has rated in this period before.',
    url: File.join(ENV['HOST'], "/steps/#{Step::PERIOD_RATING}/manifest"),
    variables_attributes: [
      { name: 'result', display_name: 'Rating code',
        description: 'Return Code  if a call period matches and the phone number has not rated in that period yet. <br/> Return -1 if call period does not match or the phone number already provided rating in that period.',
        kind: 'numeric', direction: 'outgoing' }
    ]
  },
  {
    name: Step::STORE_PERIOD_RATING,
    display_name: 'Store Period Rating',
    description: 'Description of "store period rating": This external step saves the phone number that provided the rating',
    url: File.join(ENV['HOST'], "/steps/#{Step::STORE_PERIOD_RATING}/manifest"),
    variables_attributes: [
      { name: 'result', display_name: 'Result',
        description: "Return 1 if the number is stored <br/> Return 0 if the number isn't stored",
        kind: 'numeric', direction: 'outgoing' }
    ]
  },
  {
    name: Step::NEW_CALLER,
    display_name: 'New Caller',
    description: "This external step detects if a caller's phone number is a new number call to hotline",
    url: File.join(ENV['HOST'], "/steps/#{Step::NEW_CALLER}/manifest"),
    variables_attributes: [
      {
        name: 'result', display_name: 'Result', 
        description: "Return 1 if the call is a new number <br/> Return 0 if the call isn't new number",
        kind: 'numeric', direction: 'outgoing'
      }
    ]
  }
]

steps.each do |attrs|
  step = Step.where(name: attrs[:name]).first_or_initialize
  step.update_attributes(attrs)
end
