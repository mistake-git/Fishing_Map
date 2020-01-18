class RemoveMonthFromFish < ActiveRecord::Migration[5.2]
  def change
      remove_column :fish, :month, :date
  end
end
