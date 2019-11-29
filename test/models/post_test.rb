require 'test_helper'
class PostTest < ActiveSupport::TestCase
    
   test "create_post" do
     post=Post.create(name: "fish",number: 2,date: Date.new(2019,04,02),description:'hogehoge',feed:'ゴカイ',weather:'晴れ')
     assert_equal('fish',post.name)
   end
   
   test"destroy_post" do
     post=Post.create(id:100,name: "fish",number: 2,date: Date.new(2019,04,02),description:'hogehoge',feed:'ゴカイ',weather:'晴れ')
     post.destroy
     assert_empty(Post.where(id: 100))
     
   end       
   
end
