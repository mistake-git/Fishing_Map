require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
    setup do
      @user = users :one
    end
    
    test "creating a User" do
        visit sigin_up_url
        click_on "新規登録"
        assert_selector text: "新規登録"
        fill_in "user_name", with: 'masa'
        fill_in "user_email", with: 'test@gmail.com'
        select( "兵庫県", from: 'user_address')
        click_on "新規登録"
        assert_selector ".user-name",text: 'masa'
        assert_selector ".user-email",text:'test@gmail.com'
        assert_selector ".user-address",text:'兵庫県'
        assert_text "ユーザーを作成しました"
    end
    
    test "updating a User" do
        visit user_url(@user)
        click_on "設定"
        assert_selector text: "アカウント"
        fill_in "user_name", with: 'masa'
        fill_in "user_email", with: 'test@gmail.com'
        select( "兵庫県", from: 'user_address')
        fill_in "user_introduce", with: 'よろしくお願いします'
        click_on "編集する"
        assert_selector ".user-name",text: 'masa'
        assert_selector ".user-email",text:'test@gmail.com'
        assert_selector ".user-address",text:'兵庫県'
        assert_selector ".user-introduce",text:'よろしくお願いします'
        assert_text "ユーザー情報を編集しました"
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