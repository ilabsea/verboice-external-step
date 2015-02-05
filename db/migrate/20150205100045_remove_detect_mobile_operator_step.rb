class RemoveDetectMobileOperatorStep < ActiveRecord::Migration
  def up
    Step.find_by_name('detect_mobile_operator').destroy
  end

  def down
    Step.create!(
      name: 'detect_mobile_operator',
      display_name: 'Detect Mobile Operator',
      description: 'Detect Mobile Operator',
      url: File.join(ENV['HOST'], '/steps/detect_mobile_operator/manifest'),
      variables_attributes: [
        { name: 'result', display_name: 'Mobile operator code', description: 'The mobile operator code', kind: 'numeric', direction: 'outgoing' }
      ]
    )
  end
end
