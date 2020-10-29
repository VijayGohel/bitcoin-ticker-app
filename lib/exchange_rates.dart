import 'networking.dart';

const String apiKey = 'F1E43847-E3A8-4927-9997-F7DA75A163F2';
const String urlPart = 'https://rest.coinapi.io/v1/exchangerate';

class ExchangeRates {
  Future getExchangeRates(String crypto, String currency) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$urlPart/$crypto/$currency?apikey=$apiKey');
    var exchangeRates = await networkHelper.getResponse();
    print(exchangeRates);
    return exchangeRates;
  }
}
