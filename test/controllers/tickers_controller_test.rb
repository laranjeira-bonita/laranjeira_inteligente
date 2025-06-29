require "test_helper"

class TickersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticker = tickers(:one)
  end

  test "should get index" do
    get tickers_url
    assert_response :success
  end

  test "should get new" do
    get new_ticker_url
    assert_response :success
  end

  test "should create ticker" do
    assert_difference("Ticker.count") do
      post tickers_url, params: { ticker: { category: @ticker.category, rate: @ticker.rate } }
    end

    assert_redirected_to ticker_url(Ticker.last)
  end

  test "should show ticker" do
    get ticker_url(@ticker)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticker_url(@ticker)
    assert_response :success
  end

  test "should update ticker" do
    patch ticker_url(@ticker), params: { ticker: { category: @ticker.category, rate: @ticker.rate } }
    assert_redirected_to ticker_url(@ticker)
  end

  test "should destroy ticker" do
    assert_difference("Ticker.count", -1) do
      delete ticker_url(@ticker)
    end

    assert_redirected_to tickers_url
  end
end
