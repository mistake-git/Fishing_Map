require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
    setup do
      @user = users :one
    end
    
    test "creating a User" do
        visit "/users/sign_up"
        assert_selector ".form-title",text:"新規登録"
        fill_in "new-name", with: "test"
        fill_in "new-email", with: "test@gmail.com"
        fill_in "new-password",with:"testtest"
        fill_in "new-password_confirmation",with:"testtest"
        select( "兵庫県", from:'new-address')
        click_on "user-create-btn"
        assert_text "アカウントを作成しました"
        click_on "マイページ"
        assert_selector ".user-name",text: "test"
        assert_selector ".user-address",text:"兵庫県"
        visit "/users"
        assert_text "test"
        assert_text'兵庫県'
    end
    
    test "creating a User failure" do
        visit "/users/sign_up"
        assert_selector ".form-title",text:"新規登録"
        fill_in "new-name", with: ""
        fill_in "new-email", with: ""
        fill_in "new-password",with:""
        fill_in "new-password_confirmation",with:""
        click_on "user-create-btn"
        assert_text "メールアドレスが入力されていません。"
        assert_text "パスワードが入力されていません。"
        assert_text "名前が入力されていません。"
        assert_text "主な活動エリアが入力されていません"
    end
    
    test "updating a User" do
        sign_in
        visit "/users/1"
        click_on "設定"
        assert_text"アカウント"
        fill_in "edit-name", with: "masataka"
        fill_in "edit-email", with: "masa@gmail.com"
        select( "兵庫県", from: 'edit-address')
        fill_in "edit-introduce", with: "こんにちは"
        click_on "編集する"
        assert_selector ".user-name",text: "masataka"
        assert_selector ".user-address",text:"兵庫県"
        assert_selector ".user-introduce",text:"こんにちは"
        assert_text "ユーザー情報を編集しました"
        visit "/users"
        assert_text "masataka"
        assert_text "兵庫県"
        assert_text "こんにちは"
    end
    
    test "updating a User failure" do
        sign_in
        visit "/users/1"
        click_on "設定"
        assert_text"アカウント"
        fill_in "edit-name", with: ""
        fill_in "edit-email", with: ""
        click_on "編集する"
        assert_text "メールアドレスが入力されていません。"
        assert_text "名前が入力されていません。"
    end
    
    test "Search a User" do
        sign_in
        visit "/users"
        assert_text "masa"
        assert_text "taka"
        fill_in "search", with: "masa"
        click_on "検索"
        assert_text "masa"
        assert_no_text "taka"
    end
    
    test "sign in" do
        visit "/users/sigin_in"
        assert_text"ログイン"
        fill_in "session-email", with:"test@example.com"
        fill_in "session-password",with:"testtest"
        click_on "login-btn"
        assert_text "ログアウト"
        assert_text "ログインしました"
    end
    
    test "sign out" do
        sign_in
        click_on "ログアウト"
        assert_text "ログアウトしました"
        assert_text "ログイン"
        assert_text "新規登録"
    end
 
end