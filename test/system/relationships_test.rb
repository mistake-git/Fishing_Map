require "application_system_test_case"

class RelationshipsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @user = users(:one)
    sign_in
  end
  
  test "creating a Relationship" do
    visit users_url(@user)
    click_on"フォローする"
    assert_selector "nufollow-btn-lg",text: "フォロー中"
    assert_selector "header-follow-text",text: "フォロワー1"
    
  end

 test "destroying a Relationship" do
    visit users_url(@user)
    click_on"フォロー中"
    assert_selector "follow-btn-lg",text: "フォローする"
    assert_selector "header-follow-text",text: "フォロワー0"
  end
end
