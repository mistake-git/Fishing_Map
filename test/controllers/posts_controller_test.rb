# require 'test_helper'

# class PostsControllerTest < ActionDispatch::IntegrationTest
#   setup do
#     @post = posts(:one)
#   end

#   test "should get index" do
#     get posts_url
#     assert_response :success
#   end

#   test "should get new" do
#     get new_post_url
#     assert_response :success
#   end

#   test "should create post" do
#     assert_difference('Post.count') do
#       post posts_url, params: { post: { 
#       feed: 'new_feed', name: 'new_name' ,weather:'new_weather',description:'new_description',number:'new_number',date:'new_date'
#       }}
#     end

#     post = Post.last
#     assert_equal 'new_feed', post.feed
#     assert_equal 'new_name', post.name
#     assert_equal 'new_weather', post.weather
#     assert_equal 'new_description', post.description
#     assert_equal 'new_number', post.number
#     assert_equal 'new_date', post.date
    


#     assert_redirected_to post_url(Post.last)
#     follow_redirect!
#     assert_select '.post-feed', "Feed:new_feed"
#     assert_select '.post-name', "Name:new_name"
#     assert_equal 'post_weather',"Weather:new_weather"
#     assert_equal 'post_description',"Description:new_description"
#     assert_equal 'post_number',"Number:new_number"
#     assert_equal 'post_date',"Date:new_date"
#   end

#   test "should show post" do
#     get post_url(@post)
#     assert_response :success
#   end

#   test "should get edit" do
#     get edit_post_url(@post)
#     assert_response :success
#   end

#   test "should update post" do
#     patch post_url(@post), params: { post: { 
#         feed: @post.feed, name: @post.name,weather: @post.weather,description: @post.description,number: @post.number,date: @post.date
#     }}
#     assert_redirected_to post_url(@post)
#   end

#   test "should destroy post" do
#     assert_difference('Post.count', -1) do
#       delete post_url(@post)
#     end

#     assert_redirected_to posts_url
#   end
# end
