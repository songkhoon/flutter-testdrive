import 'package:testdrive/MVP/Contacts/data/contact_data.dart';
import 'package:testdrive/MVP/Contacts/data/contact_data_impl.dart';
import 'package:testdrive/MVP/Contacts/data/contact_data_mock.dart';

enum Flavor { MOCK, PRO }

class Injector {
  static final Injector _singleton = new Injector._internal();
  Flavor _flavor;

  ContactRepository get contactRepository {
    switch (_flavor) {
      case Flavor.MOCK:
        return new MockContactRepository();
      default:
        return new RandomUserRepository();
    }
  }

  void set flavor(Flavor value) {
    _flavor = value;
  }

  void configure(Flavor flavor) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();
}
