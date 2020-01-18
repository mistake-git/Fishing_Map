class AddSeasonEndToFish < ActiveRecord::Migration[5.2]
  def change
      add_column :fish, :season_end, :date
  end
end
