json.extract! ticker, :id, :rate, :category, :created_at, :updated_at
json.url ticker_url(ticker, format: :json)
