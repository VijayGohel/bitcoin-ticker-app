import 'dart:ffi';

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
  String cryptoRate = '?';

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

    cryptoRate = '?';

    var exchangeRatesData =
        await exchangeRates.getExchangeRates(crypto, currency);

    double cryptoRateDouble;
    setState(() {
      cryptoRateDouble = exchangeRatesData['rate'];
      cryptoRate = cryptoRateDouble.toStringAsFixed(0);
    });

    print('in decodeExchange');
    print('$cryptoRate $currentCur');
    print(cryptoRateDouble.toString());
  }

  @override
  void initState() {
    super.initState();
    print('in initstate');

    setState(() {
      decodeExchangeRates('BTC', 'AUD');
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $cryptoRate $currentCur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
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
