require 'test_helper'
class PostTest < ActiveSupport::TestCase
    
   test "create_fish" do
     fish = Fish.create(name: 'fish',number: 2,season_bigin: Date.new(2019,04,02),season_end:Date.new(2019,04,02))
     assert_equal('fish',fish.name)
     assert_equal(2,fish.level)
     assert_equal(2019,04,02,fish.season_bigin)
     assert_equal(2019,04,02,fish.season_end)
   end
   
    test "update_fish" do
     fish= Fish.find_by(id: 1)    
     fish = Fish.update(name: 'fish',number: 2,season_bigin: Date.new(2019,05,02),season_end:Date.new(2019,05,02))
     assert_equal('fish',fish.name)
     assert_equal(2,fish.level)
     assert_equal(2019,05,02,fish.season_bigin)
     assert_equal(2019,05,02,fish.season_end)
   end
   
   test"destroy_fish" do
     fish = Fish.create(id: 100,name: 'fish',number: 2,season_bigin: Date.new(2019,04,02),season_end:Date.new(2019,04,02))
     fish.destroy
     assert_empty(Fish.where(id: 100))
   end       
end
