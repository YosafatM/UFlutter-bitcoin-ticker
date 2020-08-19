import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  double rateBTC = 0.0;
  double rateETH = 0.0;
  double rateLTC = 0.0;

  Widget getAndroidDropbox() {
    List<DropdownMenuItem<String>> list = [];

    for (String currency in currenciesList) {
      list.add(
        DropdownMenuItem<String>(
          child: Text(currency),
          value: currency,
        ),
      );
    }

    return DropdownButton<String>(
      value: currency,
      items: list,
      onChanged: (value) {
        setState(() {
          currency = value;
          updateUI();
        });
      },
    );
  }

  Widget getCupertinoPicker() {
    List<Text> list = [];

    for (String currency in currenciesList) {
      list.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (int value) {
        setState(() {
          currency = currenciesList[value];
          updateUI();
        });
      },
      children: list,
      itemExtent: 32.0,
    );
  }

  @override
  void initState() {
    super.initState();
    updateUI();
  }

  void updateUI() async {
    dynamic jsResponseBTC = await CoinData.getCoinData('BTC', currency);
    dynamic jsResponseETH = await CoinData.getCoinData('ETH', currency);
    dynamic jsResponseLTC = await CoinData.getCoinData('LTC', currency);

    if (jsResponseBTC != null &&
        jsResponseBTC != null &&
        jsResponseBTC != null) {
      setState(() {
        rateBTC = jsResponseBTC['rate'];
        rateETH = jsResponseETH['rate'];
        rateLTC = jsResponseLTC['rate'];
      });
    }
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
                  '1 BTC = ${rateBTC.toStringAsFixed(2)} $currency',
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
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${rateETH.toStringAsFixed(2)} $currency',
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
            padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${rateLTC.toStringAsFixed(2)} $currency',
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
            child: Platform.isIOS ? getCupertinoPicker() : getAndroidDropbox(),
          ),
        ],
      ),
    );
  }
}
