require 'test_helper'
class PostTest < ActiveSupport::TestCase
    
   test "create_fish" do
     fish = Fish.create(name: 'タイ',season_begin: Date.new(2019,04,02),season_end:Date.new(2019,04,02),level: 2)
     assert_equal('タイ',fish.name)
     assert_equal(2,fish.level)
     assert_equal(Date.new(2019,04,02),fish.season_begin)
     assert_equal(Date.new(2019,04,02),fish.season_end)
   end
   
    test "update_fish" do
     data = fish :one   
     data.update(name: 'タイ',season_begin: Date.new(2019,05,02),season_end:Date.new(2019,05,02),level: 2)
     assert_equal('タイ',data.name)
     assert_equal(2,data.level)
     assert_equal(Date.new(2019,05,02),data.season_begin)
     assert_equal(Date.new(2019,05,02),data.season_end)
   end
   
   test"destroy_fish" do
     fish = Fish.create(id: 100,name: 'タイ',season_begin: Date.new(2019,04,02),season_end:Date.new(2019,04,02))
     fish.destroy
     assert_empty(Fish.where(id: 100))
   end       
end
