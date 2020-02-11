require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @post = posts(:one)
    sign_in
  end
  
  test "creating a Post" do
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
    fill_in("map_lat", with: 35.000000, fill_options: {ignore_hidden_elements: false})
    fill_in("map_lng", with: 135.000000, fill_options: {ignore_hidden_elements: false})
    click_on "登録する"
    assert_selector ".post-name",text: "タイ"
    assert_selector ".post-number",text:"3.0匹"
    assert_selector ".post-date",text:'2019/04/02'
    assert_selector ".description",text: "これは魚です"
    assert_selector ".post-feed",text: "ゴカイ"
    assert_selector ".post-weather",text:"晴れ"
    assert_selector ".post-address",text:"兵庫県明石市"
    assert_selector ".post-size",text: 30
    assert_text "投稿を作成しました"
  end

  test "updating a Post" do
    visit "/posts/1"
    click_on "編集", match: :first
    assert_selector ".form-title", text: "釣果を編集"
    fill_in "post_name", with:"カサゴ"
    fill_in "post_number",with: 3
    select('2019',from: "post_date_1i")
    select I18n.l(Date.new(2019,05,02), format: '%B'), from: "post_date_2i"
    select("2",from: "post_date_3i")
    fill_in "post_description",with: "これは魚です"
    select( "貝", from: "post_feed")
    select( "雨", from: "post_weather")
    fill_in "post_address",with: "兵庫県神戸"
    fill_in "post_size",with:25
    click_on "登録する"
    assert_selector ".post-name",text: "カサゴ"
    assert_selector ".post-number",text:"3.0"
    assert_selector ".post-date",text:'2019/05/02'
    assert_selector ".description",text: "これは魚です"
    assert_selector ".post-feed",text: "貝"
    assert_selector ".post-weather",text:"雨"
    assert_selector ".post-address",text:"兵庫県神戸"
    assert_selector ".post-size",text: 25
    assert_text "投稿を編集しました"
 end

 test "destroying a Post" do
    page.accept_confirm do
        visit "/posts/1"
        click_on "削除", match: :first
    end    
        assert_no_text('fish')
        assert_no_text(3)
        assert_no_text("2019/04/02")
        assert_no_text("これは魚です")
        assert_no_text("ゴカイ")
        assert_no_text("晴れ")
        assert_no_text(30)
        assert_text "投稿を削除しました"
  end
end
