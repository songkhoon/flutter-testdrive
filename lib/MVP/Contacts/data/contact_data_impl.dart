import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:testdrive/MVP/Contacts/data/contact_data.dart';

/*
{
	"gender": "male",
	"name": {
		"title": "mr",
		"first": "frank",
		"last": "hopkins"
	},
	"location": {
		"street": "7987 first street",
		"city": "australian capital territory",
		"state": "victoria",
		"postcode": 8504
	},
	"email": "frank.hopkins@example.com",
	"login": {
		"username": "greenrabbit790",
		"password": "187187",
		"salt": "5hyoeuEH",
		"md5": "2cd95ed462b61450b1262818abbcc19f",
		"sha1": "e2270d6ef45a4757291f0c41097917db972e609e",
		"sha256": "6cce67b19300ebb42dce48df5289f0e39c6124f0da269566ddf6b5016ee508f9"
	},
	"dob": "1985-12-30 11:14:30",
	"registered": "2005-11-24 10:28:44",
	"phone": "01-3923-5668",
	"cell": "0463-243-695",
	"id": {
		"name": "TFN",
		"value": "838919129"
	},
	"picture": {
		"large": "https://randomuser.me/api/portraits/men/5.jpg",
		"medium": "https://randomuser.me/api/portraits/med/men/5.jpg",
		"thumbnail": "https://randomuser.me/api/portraits/thumb/men/5.jpg"
	},
	"nat": "AU"
}
*/
class RandomUserRepository implements ContactRepository {
  static const _kRandomUserUrl = "http://api.randomuser.me/?results=15";
  final JsonDecoder _decoder = new JsonDecoder();

  @override
  Future<List<Contact>> fetch() {
    return http.get(_kRandomUserUrl)
    .then((response) {
      final jsonBody = response.body;
      final statusCode = response.statusCode;
      if(statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException("Error while getting contacts [StatusCode: $statusCode]");
      }

      final contactsContainer = _decoder.convert(jsonBody);
      final List contactItems = contactsContainer['results'];
      
      return contactItems.map((contactRow) => new Contact.fromMap(contactRow)).toList();
    });
  }

}