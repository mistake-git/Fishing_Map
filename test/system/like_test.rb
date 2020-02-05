require "application_system_test_case"

class LikesTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    visit "/users/sigin_in"
    fill_in "one_email", with: "masa@example.com"
    fill_in "one_password",with:"<%= Devise::Encryptor.digest(User, 'password') %>"
    click_on "ログイン"
    @post = posts(:one)
  end
  
  test "creating a Like" do
    visit post_url(@post)
    click_on".like-btn-unlike"
    assert_selector "like-btn"
    assert_selector "like-icon",text: 1
  end

 test "destroying a Like" do
    visit post_url(@post)
    click_on".unlike-btn-unlike"
    assert_selector "like-btn"
    assert_selector "like-icon",text: 0
  end
end