class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :ticker, presence: true
  def self.new_lookup(ticker_symbol)
    query = BasicYahooFinance::Query.new
    data = query.quotes(ticker_symbol, 'price')

    if data.key?(ticker_symbol) && data[ticker_symbol].key?('regularMarketPrice')
      price_raw = data[ticker_symbol]['regularMarketPrice']['raw']

      stock = find_by_ticker(ticker_symbol)
      if stock
        stock.update(last_price: price_raw)
      else
        stock = create(ticker: ticker_symbol, last_price: price_raw)
      end

      stock
    else
      # Return nil if the data doesn't have the expected structure
      nil
    end
  end

  def price_formatted
    # Assuming you have a column in the Stock model called `last_price`
    # This method should return the formatted price information
    return '$' + last_price.to_s if last_price.present?

    # If no price information is available, return 'N/A' or any other suitable value
    'N/A'
  end

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

end
