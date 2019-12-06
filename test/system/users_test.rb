require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
    setup do
      @user = users(:one)
    end
    
    test "sign in" do
    visit users_url
    click_on "ログイン"
    assert_selector "h4", text: "ログイン"
    fill_in "users_emai", with: 'masa@example.com'
    fill_in "users_password",with:"<%= Devise::Encryptor.digest(User, 'password') %>"
    click_on "ログイン"
    assert_selector ".nave-link",text: 'ログアウト'
    end
    
    test "sign out" do
    visit users_url
    click_on "ログアウト"
    assert_selector ".nave-link",text: 'ログイン'
    end
  
  
    
end