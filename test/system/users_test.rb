require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
    setup do
      @user = users :one
    end
    
    test "creating a User" do
        visit "/users/sign_up"
        assert_selector"h4",text:"新規登録"
        fill_in "new-name", with: "test"
        fill_in "new-email", with: "test@gmail.com"
        fill_in "new-password",with:"testtest"
        fill_in "new-password_confirmation",with:"testtest"
        select( "兵庫県", from:'new-address')
        click_on "user-create-btn"
        assert_text "アカウントを作成しました"
        click_on "マイページ"
        assert_selector ".user-name",text: "test"
        assert_selector ".user-address",text:'兵庫県'
        
    end
    
    test "updating a User" do
        sign_in
        visit "/users/1"
        click_on "設定"
        assert_selector text: "アカウント"
        fill_in "one_name", with: "masa"
        fill_in "one_email", with: "test@gmail.com"
        select( "兵庫県", from: 'one_address')
        fill_in "one_introduce", with: "よろしくお願いします"
        click_on "user-update-btn"
        assert_selector ".user-name",text: "masa"
        assert_selector ".user-email",text:"test@gmail.com"
        assert_selector ".user-address",text:"兵庫県"
        assert_selector ".user-introduce",text:"よろしくお願いします"
        assert_text "ユーザー情報を編集しました"
    end
    
    test "sign in" do
        visit "/users/sigin_in"
        assert_selector "h4", text: "ログイン"
        fill_in "session-email", with:"test@example.com"
        fill_in "session-password",with:"testtest"
        click_on "login-btn"
        assert_text "ログアウト"
        assert_text "ログインしました"
    end
    
    test "sign out" do
        sign_in
        click_on "ログアウト"
        assert_text  "ログイン"
        assert_text "ログアウトしました"
    end
 
end