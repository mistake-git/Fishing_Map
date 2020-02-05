require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    visit "/users/sigin_in"
    fill_in "one_email", with: "masa@example.com"
    fill_in "one_password",with:"<%= Devise::Encryptor.digest(User, 'password') %>"
    click_on "ログイン"
    @post = posts(:one)
  end
  
  test "creating a Comment" do
    visit post_url(@post)
    fill_in "MyText1", with: "いいですね"
    assert_selector ".comment-content",text:"いいですね"
    assert_selector ".comment-icon",text:1
    assert_text "コメントを投稿しました"
   
  end

 test "destroying a Comment" do
    visit post_url(@post)
    fill_in "MyText1", with: "いいですね"
    assert_selector ".comment-content",text:"いいですね"
    click_on "削除", match: :first
    assert_no_text"いいですね"
    ssert_selector ".comment-icon",text:0
    assert_text "コメントを削除しました"
  end
end
