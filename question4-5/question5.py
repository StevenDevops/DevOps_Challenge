from binance.spot import Spot as Client
from prometheus_client import start_http_server, Gauge
import pandas as pd
import json
import time

class BinanceProducer:

    def __init__(self):
        API_BASE_URL = "https://api.binance.com/api"
        self.spot_client = Client(API_BASE_URL)

    def test_connectivity(self):
        '''
        GET /api/v3/ping
        https://binance-docs.github.io/apidocs/spot/en/#test-connectivity
        '''

        while True:
            try:
                self.spot_client.ping()
                print("Looks good")
                break
            except Exception as e:
                print("There are something wrong with Binance APIs.", e)
                print("Retry in 5s")
                time.sleep(5) # Keeps trying every 5s

    def get_symbols_by_quote_asset(self,quoteAsset):
        '''
        GET /api/v3/exchangeinfo
        https://binance-docs.github.io/apidocs/spot/en/#exchange-information
        '''

        symbols = self.spot_client.exchange_info()
        symbols_lst = []

        df = pd.DataFrame(symbols["symbols"])

        for index, data in df.iterrows():
            if data["quoteAsset"] == quoteAsset:
                symbols_lst.append(data["symbol"])
        return symbols_lst

    def get_top_symbols_by_quote_asset(self,top,quoteAsset,type):
        '''
        GET /api/v3/ticker/24hr
        https://binance-docs.github.io/apidocs/spot/en/#24hr-ticker-price-change-statistics
        '''

        # Collect sysmbols by quoteAsset
        symbol_by_quoteAsset = self.get_symbols_by_quote_asset(quoteAsset)
        r = self.spot_client.ticker_24hr(symbols=symbol_by_quoteAsset)
        df = pd.DataFrame.from_dict(r)
        df = df[["symbol", type]]

        # Convert to numeric for sorting
        df[type] = pd.to_numeric(df[type], downcast="float", errors="coerce")
        df = df.sort_values(by=[type], ascending=False).head(top)

        # Print the results
        print("\n Top %s Symbols for %s by %s \n" %  (top, quoteAsset, type))
        print(df.to_string(index = False))

if __name__ == "__main__":
    client = BinanceProducer()
    client.test_connectivity()
    client.get_top_symbols_by_quote_asset(1,'BTC','volume')
