require "application_system_test_case"

class LikesTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @post = posts(:one)
    sign_in
  end
  
  test "creating a Like" do
    visit "/posts/1"
    find(".like-btn-unlike").click
    assert_selector "like-btn"
    assert_selector "like-icon",text: 1
  end

 test "destroying a Like" do
    visit "/posts/1"
    find(".like-btn-unlike").click
    find(".like-btn").click
    assert_selector "like-btn-unlike"
    assert_selector "like-icon",text: 0
  end
end