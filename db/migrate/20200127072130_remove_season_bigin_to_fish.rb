class RemoveSeasonBiginToFish < ActiveRecord::Migration[5.2]
  def change
      remove_column :fish, :season_bigin, :date
  end
end
