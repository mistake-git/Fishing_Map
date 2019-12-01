require 'test_helper'
class PostTest < ActiveSupport::TestCase
    
   test "create_post" do
     post=Post.create(name: 'fish',number: 2,date: Date.new(2019,04,02),description:'hogehoge',feed:'ゴカイ',weather:'晴れ')
     assert_equal('fish',post.name)
     assert_equal(2,post.number)
     assert_equal(2019,04,02,post.date)
     assert_equal('hogehoge',post.description)
     assert_equal('ゴカイ',post.feed)
     assert_equal('晴れ',post.weather)
   end
   
    test "update_post" do
     post=Post.find_by(id: 1)    
     post=Post.update(name: 'fish',number: 2,date: Date.new(2019,04,02),description:'hogehoge',feed:'ゴカイ',weather:'晴れ')
     assert_equal('fish',post.name)
     assert_equal(2,post.number)
     assert_equal(2019,04,02,post.date)
     assert_equal('hogehoge',post.description)
     assert_equal('ゴカイ',post.feed)
     assert_equal('晴れ',post.weather)
   end
   
   test"destroy_post" do
     post=Post.create(id:100,name: "fish",number: 2,date: Date.new(2019,04,02),description:'hogehoge',feed:'ゴカイ',weather:'晴れ')
     post.destroy
     assert_empty(Post.where(id: 100))
     
   end       
   
end
