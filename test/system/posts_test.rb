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
    fill_in "post_date",with: '2019/04/02'
    fill_in "post_description",with: 'これは魚です'
    fill_in "post_feed", with: 'ゴカイ'
    fill_in "post_weather",with:'晴れ'
   
    click_on "登録する"
    assert_selector ".post-name",text: 'fish'
    assert_selector ".post-number",text:3
    assert_selector ".post-date",text:'2019/04/02'
    assert_selector ".post-description",text: 'これは魚です'
    assert_selector ".post-feed",text: 'ゴカイ'
    assert_selector ".post-weather",text:'晴れ'
    assert_text "投稿を作成しました"
  end

    test "updating a Post" do
    visit edit_post_url(posts(:one))
    click_on "編集", match: :first
    assert_selector "h4", text: "釣果を編集する"
    fill_in "post_name", with: 'fish'
    fill_in "post_number",with: 3
    fill_in "post_date",with: '2019/04/02'
    fill_in "post_description",with: 'これは魚です'
    fill_in "post_feed", with: 'ゴカイ'
    fill_in "post_weather",with:'晴れ'
   
    click_on "登録する"
    assert_selector ".post-name",text: 'fish'
    assert_selector ".post-number",text:3
    assert_selector ".post-date",text:'2019/04/02'
    assert_selector ".post-description",text: 'これは魚です'
    assert_selector ".post-feed",text: 'ゴカイ'
    assert_selector ".post-weather",text:'晴れ'
    assert_text "投稿を編集しました"
   end

    test "destroying a Post" do
      visit posts_url
      page.accept_confirm do
      click_on "削除", match: :first
      assert_not_text
     end
     assert_text "投稿を削除しました"
   end
end
