import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:testdrive/MVP/CryptoApp/data/Crypto.dart';
import 'package:testdrive/MVP/CryptoApp/presenter/CryptoPresenter.dart';

class CryptoView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> implements CryptoListViewContract {
  CryptoListPresenter _presenter;
  List<Crypto> _currencies;
  bool _isLoading;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  _CryptoViewState() {
    _presenter = new CryptoListPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadCurrencies();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text("Crypto App"),
          elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
        ),
        body: _isLoading
            ? new Center(
                child: new CircularProgressIndicator(),
              )
            : _cryptoWidget());
  }

  @override
  void onLoadCryptoComplete(List<Crypto> items) {
    setState(() {
      _currencies = items;
      _isLoading = false;
    });
  }

  @override
  void onLoadCryptoError() {
    print("load crypto error");
  }

  Widget _cryptoWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
              child: new ListView.builder(
                  itemBuilder: (context, index) {
                    final Crypto currency = _currencies[index];
                    final MaterialColor color = _colors[index % _colors.length];
                    return _getListItemUI(currency, color);
                  },
                itemCount: _currencies.length,
          ))
        ],
      ),
    );
  }

  ListTile _getListItemUI(Crypto currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency.name[0]),
      ),
      title: new Text(
        currency.name,
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle:
          _getSubtitleText(currency.price_usd, currency.percent_change_1h),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget = new TextSpan(
      text: "\$$priceUSD\n",
      style: new TextStyle(color: Colors.black),
    );
    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: percentageChangeText, style: new TextStyle(color: Colors.red));
    }

    return new RichText(
        text: new TextSpan(
            children: [priceTextWidget, percentageChangeTextWidget]));
  }
}
