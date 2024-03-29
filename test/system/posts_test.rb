require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @post = posts(:one)
    sign_in
  end
  
  test "creating a Post" do
   creating_post
   find('.notification').click
   assert_text "通知はありません"
  end
  
  test "creating a Post failure" do
    visit "/posts/new"
    assert_selector ".form-title", text: "釣果を登録"
    click_on "登録する"
    assert_text"魚種が入力されていません。"
    assert_text"魚種はカタカナで入力して下さい。"
    assert_text"住所が入力されていません。"
    assert_text"緯度が入力されていません。"
    assert_text"経度が入力されていません。"
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
    assert_selector ".post-number",text:"3匹"
    assert_selector ".post-date",text:'2019/05/02'
    assert_selector ".description",text: "これは魚です"
    assert_selector ".post-feed",text: "貝"
    assert_selector ".post-weather",text:"雨"
    assert_selector ".post-address",text:"兵庫県神戸"
    assert_selector ".post-size",text: 25
    assert_text "投稿を編集しました"
    visit "/posts"
    assert_text "カサゴ"
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
  
  test "Search a Post" do
        click_on "すべての釣果"
        assert_text "タイ"
        assert_text "カサゴ"
        fill_in "search", with: "タイ"
        click_on "検索"
        assert_text "タイ"
        assert_no_text "カサゴ"
  end
end
