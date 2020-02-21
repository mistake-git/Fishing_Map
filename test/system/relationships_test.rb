require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @user = users(:one)
    sign_in
  end
  
  test "creating a Relationship" do
    visit "/users/3"
    click_on "フォローする"
    assert_text "フォローしました｡フォローすると釣果の通知を受け取る事ができます｡"
    assert_text "フォロワー 1"
    find('.notification').click
    assert_text "通知はありません"
  end

 test "destroying a Relationship" do
    visit "/users/3"
    click_on "フォローする"
    click_on "フォロー中"
    assert_text "フォローを解除しました｡"
    assert_text "フォロワー 0"
  end
end
