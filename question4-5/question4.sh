#!/bin/bash

API_BASE_URL="https://api.binance.com/api"
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###
# Functions
### ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ###

_get_top_symbol_by_quote_asset () {
  # Clean file temp
  echo > temp.txt
  symbols=$(curl -sX GET "https://api.binance.com/api/v3/exchangeInfo" | jq -r '.symbols[] | select(.quoteAsset=="BTC")' | jq -r .symbol | sort)
  for s in $symbols
  do
    volume=$(curl -sXGET "https://api.binance.com/api/v3/ticker/24hr?symbol=$s" | jq -r .volume)
    echo "$s $volume" >> temp.txt
  done

  # Get the top symbol and value from temp.txt file
  awk '
  $2>max || max=="" {   # or $2>=max, depending on if you want first or last
      max=$2
      val=$1
  }
  END {
      print "The top symbol with quote asset BTC is " val " and the highest volume over the last 24 hours is " max
  }' temp.txt

}

_get_top_symbol_by_quote_asset