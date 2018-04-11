import 'dart:async';
import 'package:testdrive/MVP/Contacts/data/contact_data.dart';

const kContacts = const <Contact>[
  const Contact(
      fullName: 'lotte herrmann',
      gender: 'female',
      email:'romain.hoogmoed@example.com',
      imageUrl: 'https://randomuser.me/api/portraits/women/17.jpg',
      birthday: 'Birthday May 25, 1949',
      location: const Location(street: '5526 kiefernweg', city: 'frankenthal (pfalz)'),
      phones: const <Phone>[
        const Phone(type: 'Home', number: '0617-4720085'),
        const Phone(type: 'Mobile', number: '0178-2688938'),
      ]
  ),
  const Contact(
      fullName: 'jayden fuller',
      gender: 'male',
      email:'jayden.fuller@example.com',
      imageUrl: 'https://randomuser.me/api/portraits/men/21.jpg',
      birthday: 'Birthday May 25, 1949',
      location: const Location(street: '5526 kiefernweg', city: 'frankenthal (pfalz)'),
      phones: const <Phone>[
        const Phone(type: 'Home', number: '0617-4720085'),
        const Phone(type: 'Mobile', number: '0178-2688938'),
      ]
  )
];

class MockContactRepository implements ContactRepository{

  Future<List<Contact>> fetch(){
    return new Future.value(kContacts);
  }

}

