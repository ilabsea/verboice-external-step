class RemoveIloRatingStep < ActiveRecord::Migration
  def up
    Step.find_by_name('ilo_rating').destroy
  end

  def down
    Step.create!(
      name: 'ilo_rating',
      display_name: 'ILO Rating',
      description: 'Returning the code of rating',
      url: File.join(ENV['HOST'], '/steps/ilo_rating/manifest'),
      variables_attributes: [
        { name: 'result', display_name: 'Rating code', description: 'Rating code', kind: 'numeric', direction: 'outgoing' }
      ]
    )
  end
end
