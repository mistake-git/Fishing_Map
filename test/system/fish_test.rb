require "application_system_test_case"

class FishTest < ApplicationSystemTestCase
  setup do
    @fish = fish(:one)
  end

  test "データを作成" do
    visit fish_url
    assert_selector text: "データを作成"
  end

  test "creating a Fish" do
    visit fish_url
    fill_in "難易度", with: @fish.level
    fill_in "シーズン開始", with: @fish.month
    fill_in "シーズン終了", with: @fish.month
    fill_in "魚種", with: @fish.name
    click_on "登録する"
    assert_text "魚のデータを作成しました"
  end

  test "updating a Fish" do
    visit fish_url
    click_on "編集", match: :first

    fill_in "難易度", with: @fish.level
    fill_in "シーズン開始", with: @fish.month
    fill_in "シーズン終了", with: @fish.month
    fill_in "魚種", with: @fish.name
    click_on "登録する"

    assert_text "魚のデータを編集しました"
  end

  test "destroying a Fish" do
    visit fish_url
    page.accept_confirm do
      click_on "削除", match: :first
    end
    assert_text "魚のデータを削除しました"
  end
end
