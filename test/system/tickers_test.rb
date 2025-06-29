require "application_system_test_case"

class TickersTest < ApplicationSystemTestCase
  setup do
    @ticker = tickers(:one)
  end

  test "visiting the index" do
    visit tickers_url
    assert_selector "h1", text: "Tickers"
  end

  test "should create ticker" do
    visit tickers_url
    click_on "New ticker"

    fill_in "Category", with: @ticker.category
    fill_in "Rate", with: @ticker.rate
    click_on "Create Ticker"

    assert_text "Ticker was successfully created"
    click_on "Back"
  end

  test "should update Ticker" do
    visit ticker_url(@ticker)
    click_on "Edit this ticker", match: :first

    fill_in "Category", with: @ticker.category
    fill_in "Rate", with: @ticker.rate
    click_on "Update Ticker"

    assert_text "Ticker was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticker" do
    visit ticker_url(@ticker)
    click_on "Destroy this ticker", match: :first

    assert_text "Ticker was successfully destroyed"
  end
end
