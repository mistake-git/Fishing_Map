require "application_system_test_case"

class CommentsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @post = posts(:one)
     sign_in
  end
  
  test "creating a Comment" do
    visit post_url(@post)
    fill_in "comment", with: "いいですね"
    click_on "コメントする"
    assert_text "いいですね"
    assert_selector ".comment-icon",text:1
    assert_text "コメントを投稿しました"
  end
  
  test "updating a Comment" do
    visit post_url(@post)
    fill_in "comment", with: "最高です！"
    click_on "コメントする"
    assert_text "最高です！"
    assert_selector ".comment-icon",text:1
    assert_text "コメントを投稿しました"
  end

 test "destroying a Comment" do
    visit post_url(@post)
    fill_in "comment", with: "いいですね"
    click_on "コメントする"
    assert_text "いいですね"
    click_on ('comment-destroy')
    assert_no_text"いいですね"
    assert_selector ".comment-icon",text:0
    assert_text "コメントを削除しました"
  end
  
end
