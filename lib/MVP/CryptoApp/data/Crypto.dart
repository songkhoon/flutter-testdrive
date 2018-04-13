import 'dart:async';

class Crypto {
  String name;
  String price_usd;
  String percent_change_1h;

  Crypto({this.name, this.price_usd, this.percent_change_1h});

  Crypto.fromMap(Map<String, dynamic> map)
      : name = map['name'],
        price_usd = map['price_usd'],
        percent_change_1h = map['percent_change_1h'];
}

abstract class CryptoRepository {
  Future<List<Crypto>> fetchCurrencies();
}

class FetchDataException implements Exception {
  final _message;

  FetchDataException([this._message]);

  String toString() {
    if (_message == null) return "Exception";
    return "Exception: $_message";
  }
}