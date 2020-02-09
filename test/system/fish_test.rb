require "application_system_test_case"

class FishTest < ApplicationSystemTestCase
  setup do
    @fish = fish(:one)
    sign_in
  end

  test "creating a Fish" do
    visit "/fish/new"
    assert_text"データを作成"
    select(1,from: "fish-level")
    fill_in "fish-name", with:"タイ"
    click_on "登録する"
    assert_text "魚のデータを作成しました"
    assert_text "タイ"
    assert_text "1"
  end

  test "updating a Fish" do
    visit "/fish"
    click_on "編集", match: :first
    select(2,from: "fish-level")
    fill_in "fish-name", with:"マグロ"
    click_on "登録する"
    assert_text "魚のデータを編集しました"
    assert_text "マグロ"
    assert_text "2"
  end

  test "destroying a Fish" do
    visit "/fish"
    page.accept_confirm do
    click_on "削除", match: :first
    end
    assert_text "魚のデータを削除しました"
    assert_no_text "タイ"
    assert_no_text "1"
  end
end
