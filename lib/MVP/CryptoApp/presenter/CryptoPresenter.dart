import 'package:testdrive/MVP/CryptoApp/CryptoInjector.dart';
import 'package:testdrive/MVP/CryptoApp/data/Crypto.dart';

abstract class CryptoListViewContract {
  void onLoadCryptoComplete(List<Crypto> items);

  void onLoadCryptoError();
}

class CryptoListPresenter {
  CryptoListViewContract _view;
  CryptoRepository _repository;

  CryptoListPresenter(this._view) {
    final _injector = new Injector();
    _injector.flavor = Flavor.PROD;
    _repository = _injector.cryptoRepository;
  }

  void loadCurrencies() {
    _repository
        .fetchCurrencies()
        .then((c) => _view.onLoadCryptoComplete(c))
        .catchError((onError) => _view.onLoadCryptoError());
  }
}
