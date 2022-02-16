# frozen_string_literal: true

def stock_picker(prices)
  max_profit = 0
  days = []
  (0..prices.length - 2).each do |i|
    buy_amount = prices[i]

    (i + 1..prices.length - 1).each do |j|
      sell_amount = prices[j]
      profit = sell_amount - buy_amount

      if profit > max_profit
        days = [i, j]
        max_profit = profit
      end
    end
  end

  days
end

puts stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
# [1,4]
