import 'package:testdrive/MVP/Contacts/data/contact_data.dart';
import 'package:testdrive/MVP/Contacts/injection/dependency_injection.dart';

abstract class ContactListViewContract {
  void onLoadContactsComplete(List<Contact> items);

  void onLoadContactsError();
}

class ContactListPresenter {
  ContactListViewContract _view;
  ContactRepository _repository;

  ContactListPresenter(this._view) {
    Injector injector = new Injector();
    injector.flavor = Flavor.PRO;
    _repository = injector.contactRepository;
  }

  void loadContacts() {
    assert(_view != null);

    _repository
        .fetch()
        .then((contact) => _view.onLoadContactsComplete(contact))
        .catchError((error) {
      print(error);
      _view.onLoadContactsError();
    });
  }
}
