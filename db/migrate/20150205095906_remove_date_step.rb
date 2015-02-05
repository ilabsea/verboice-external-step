class RemoveDateStep < ActiveRecord::Migration
  def up
    Step.find_by_name('date').destroy
  end

  def down
    Step.create!(
      name: 'date',
      display_name: 'Date',
      description: 'Returning the current date',
      url: File.join(ENV['HOST'], '/steps/date/manifest'),
      variables_attributes: [
        { name: 'unit', display_name: 'Date unit', description: 'Unit of date(day/week/month/year)', kind: 'date_type', direction: 'incoming' },
        { name: 'value', display_name: 'Value', description: 'Number of unit(day/week/month/year) ago', kind: 'numeric', direction: 'incoming' },
        { name: 'result', display_name: 'Date', description: 'Current datetime', kind: 'text', direction: 'outgoing' }
      ]
    )
  end
end
