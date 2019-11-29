require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  driven_by :selenium, using: :headless_chrome
  setup do
    @post = posts(:one)
  end

  test "visiting the index" do
    visit posts_url
    assert_selector "h1", text: "Fishing Map"
  end

  test "creating a Post" do
    visit posts_url
    click_on "釣果を登録する"

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
  end

  test "updating a Post" do
    visit post_url(@post)
    click_on "編集", match: :first
    assert_selector "h4", text: "釣果を編集"
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
    assert_text "投稿を編集しました"
 end

 test "destroying a Post" do
    page.accept_confirm do
        visit post_url(@post)
        click_on "削除", match: :first
    end    
        assert_no_text('fish')
        assert_no_text(3)
        assert_no_text('2019/04/02')
        assert_no_text('これは魚です')
        assert_no_text('ゴカイ')
        assert_no_text('晴れ')
    assert_text "投稿を削除しました"
  end
end
