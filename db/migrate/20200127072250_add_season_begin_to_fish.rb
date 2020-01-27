class AddSeasonBeginToFish < ActiveRecord::Migration[5.2]
  def change
       add_column :fish, :season_begin, :date
  end
end
