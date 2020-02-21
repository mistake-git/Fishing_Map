ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
    def sign_in
        visit "/users/sigin_in"
        fill_in "session-email", with:"test@example.com"
        fill_in "session-password",with:"testtest"
        click_on "login-btn"
    end
    
    def notification_sign_in
        visit "/users/sigin_in"
        fill_in "session-email", with:"masataka@gmail.com"
        fill_in "session-password",with:"masamasa"
        click_on "login-btn"
    end
    
    def creating_post
        visit "/posts/new"
        assert_selector ".form-title", text: "釣果を登録"
        fill_in "post_name", with: "タイ"
        fill_in "post_number",with: 3
        select('2019',from: "post_date_1i")
        select I18n.l(Date.new(2019,04,02), format: '%B'), from: "post_date_2i"
        select("2",from: "post_date_3i")
        fill_in "post_description",with: "これは魚です"
        select( "ゴカイ", from: "post_feed")
        select( "晴れ", from: "post_weather")
        fill_in "post_address",with: "兵庫県明石市"
        fill_in "post_size",with:30
        page.execute_script "$('#map_lat').val(35.000000);"
        page.execute_script "$('#map_lng').val(135.000000);"
        click_on "登録する"
        assert_selector ".post-name",text: "タイ"
        assert_selector ".post-number",text:"3匹"
        assert_selector ".post-date",text:'2019/04/02'
        assert_selector ".description",text: "これは魚です"
        assert_selector ".post-feed",text: "ゴカイ"
        assert_selector ".post-weather",text:"晴れ"
        assert_selector ".post-address",text:"兵庫県明石市"
        assert_selector ".post-size",text: 30
        assert_text "投稿を作成しました"
        visit "/posts"
        assert_text"タイ"
    end
  # Add more helper methods to be used by all tests here...
end
