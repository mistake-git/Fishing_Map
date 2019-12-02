require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
    setup do
      @user = users(:one)
    end
    
    test "sign in" do
    visit users_url
    click_on "ログイン"
<<<<<<< HEAD
    assert_selector "h4", text: "ログイン"
    fill_in "users_emai", with: 'masa@example.com'
    fill_in "users_password",with:"<%= Devise::Encryptor.digest(User, 'password') %>"
    click_on "ログイン"
    
=======

    assert_selector "h4", text: "釣果を登録する"
    fill_in "post_name", with: 'fish'
    fill_in "post_number",with: 3
    select('2019',from: 'post_date_1i')
    select I18n.l(Date.new(2019,04,02), format: '%B'), from: 'post_date_2i'
    select('2',from: 'post_date_3i')
    fill_in "post_description",with: 'これは魚です'
    select( "ゴカイ", from: 'post_feed')
    select( "晴れ", from: 'post_weather')
    click_on "登録する"
    assert_selector ".post-name",text: 'fish'
    assert_selector ".post-number",text:3
    assert_selector ".post-date",text:'2019-04-02'
    assert_selector ".post-description",text: 'これは魚です'
    assert_selector ".post-feed",text: 'ゴカイ'
    assert_selector ".post-weather",text:'晴れ'
    assert_text "投稿を作成しました"
>>>>>>> origin/master
  end
    
end