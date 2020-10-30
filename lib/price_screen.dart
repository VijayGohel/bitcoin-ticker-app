import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'exchange_rates.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currentCur = currenciesList[0];
  String cryptoRateBTC = '?';
  String cryptoRateETH = '?';
  String cryptoRateLTC = '?';

  DropdownButton androidDropDowm() {
    List<DropdownMenuItem<String>> listCurrency = [];
    for (String currency in currenciesList) {
      var cur = DropdownMenuItem<String>(
        child: Text(currency),
        value: currency,
      );

      listCurrency.add(cur);
    }

    return DropdownButton<String>(
      value: currentCur,
      items: listCurrency,
      onChanged: (value) {
        setState(() {
          currentCur = value;
          decodeExchangeRates('BTC', value);
          decodeExchangeRates('ETH', value);
          decodeExchangeRates('LTC', value);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Text> list = [];
    for (String cur in currenciesList) {
      list.add(Text(cur));
    }

    return CupertinoPicker(
      itemExtent: 30,
      onSelectedItemChanged: (SelectedIndex) {
        print(SelectedIndex);
        //decodeExchangeRates('BTC', value);
      },
      children: list,
    );
  }

  void decodeExchangeRates(String crypto, String currency) async {
    ExchangeRates exchangeRates = ExchangeRates();

    cryptoRateBTC = '?';
    cryptoRateETH = '?';
    cryptoRateLTC = '?';

    if (crypto == 'BTC') {
      var exchangeRatesData =
          await exchangeRates.getExchangeRates(crypto, currency);

      double cryptoRateDouble;
      setState(() {
        cryptoRateDouble = exchangeRatesData['rate'];
        cryptoRateBTC = cryptoRateDouble.toStringAsFixed(0);
      });
    } else if (crypto == 'ETH') {
      var exchangeRatesData =
          await exchangeRates.getExchangeRates(crypto, currency);

      double cryptoRateDouble;
      setState(() {
        cryptoRateDouble = exchangeRatesData['rate'];
        cryptoRateETH = cryptoRateDouble.toStringAsFixed(0);
      });
    } else {
      var exchangeRatesData =
          await exchangeRates.getExchangeRates(crypto, currency);

      double cryptoRateDouble;
      setState(() {
        cryptoRateDouble = exchangeRatesData['rate'];
        cryptoRateLTC = cryptoRateDouble.toStringAsFixed(0);
      });
    }
    print('in decodeExchange');
    print('$cryptoRateBTC $currentCur $cryptoRateETH $cryptoRateLTC');
  }

  @override
  void initState() {
    super.initState();
    print('in initstate');

    setState(() {
      decodeExchangeRates('BTC', 'AUD');
      decodeExchangeRates('ETH', 'AUD');
      decodeExchangeRates('LTC', 'AUD');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $cryptoRateBTC $currentCur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $cryptoRateETH $currentCur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $cryptoRateLTC $currentCur',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropDowm(),
          ),
        ],
      ),
    );
  }
}
