require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @post = posts(:one)
     sign_in
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
