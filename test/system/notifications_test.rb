require "application_system_test_case"

class NotificationsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  
  setup do
    notification_sign_in
  end
  
  test "creating a Notifications Like" do
    visit "/posts/1"
    find('.like-btn').click
    assert_selector('.like-btn-unlike')
    assert_selector ".like-icon",text: 1
    click_on "ログアウト"
    sign_in
    find('.notification').click
    assert_text"masaがあなたのタイの投稿にいいね!しました"
  end
  
  
  test "creating a Notifications Comment" do
    visit "/posts/1"
    fill_in "comment", with: "いいですね"
    click_on "コメントする"
    assert_text "いいですね"
    assert_selector ".comment-icon",text:1
    assert_text "コメントを投稿しました"
    click_on "ログアウト"
    sign_in
    find('.notification').click
    assert_text "masaがあなたのタイの投稿にコメントしました"
  end
  
  test "creating a Notifications Follow" do
    visit "/users/1"
    click_on "フォローする"
    assert_text "フォローしました｡フォローすると釣果の通知を受け取る事ができます｡"
    click_on "ログアウト"
    sign_in
    find('.notification').click
    assert_text "masaがあなたをフォローしました"
  end
  
  test "creating a Notifications Post" do
    visit "/users/1"
    click_on "フォローする"
    assert_text "フォローしました｡フォローすると釣果の通知を受け取る事ができます｡"
    click_on "ログアウト"
    sign_in
    creating_post
    click_on "ログアウト"
    notification_sign_in
    find('.notification').click
    assert_text "testがタイを釣り上げました"
  end
  
end