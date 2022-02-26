
import 'dart:convert';

import 'package:bitcoin_ticker/price_screen.dart';
import 'package:http/http.dart' as http;
import 'Networking.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR',
  'TRY'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];
const apiKey='829EF00F-ABEA-49DA-8C25-2157DBF97B4E';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    Map<String, String> cryptoPrices = {};
    for(String crypto in cryptoList){
      var url='https://rest.coinapi.io/v1/exchangerate/$crypto/$currency?apikey=$apiKey';
      Networking networking=Networking(url: url);
      var coinData= await networking.getData();
      cryptoPrices[crypto]=coinData.toStringAsFixed(0);
    }
    return cryptoPrices;
  }
}
