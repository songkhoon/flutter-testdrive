import 'package:testdrive/MVP/CryptoApp/data/Crypto.dart';
import 'package:testdrive/MVP/CryptoApp/data/CryptoDataMock.dart';
import 'package:testdrive/MVP/CryptoApp/data/CryptoDataProd.dart';

enum Flavor { MOCK, PROD }

//DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  Flavor _flavor;

  void set flavor(Flavor value) {
    _flavor = value;
  }

  CryptoRepository get cryptoRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockCryptoRepository();
      default:
        return new ProdCryptoRepository();
    }
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();
}