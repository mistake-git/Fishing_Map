class AddSeasonBiginToFish < ActiveRecord::Migration[5.2]
  def change
       add_column :fish, :season_bigin, :date
  end
end
