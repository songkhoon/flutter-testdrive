// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testdrive/User.dart';
import 'package:testdrive/UserModel.dart';

import 'package:testdrive/main.dart';

final json = """
  {
    "name": "John Smith",
    "email": "john@example.com",
    "gender": "male",
    "cars":[
      {"name": "car 1"},
      {"name": "car 2"}
    ]
  }
  """;

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });

  test('Test Json', () {
    print(json);
    Map<String, dynamic> user = JSON.decode(json);
    print("user name: ${user['name']}.");

    var mapUser = new User.fromJson(JSON.decode(json));
    print("user email: ${user['email']}");
    print("gender: ${mapUser.gender}");
    print("car count: ${mapUser.cars.length}");

    print("${mapUser.cars}, ${mapUser.cars.runtimeType}");
    print("name: ${mapUser.cars[0].name}, year: ${mapUser.cars[0].year}");

    var allCars = mapUser.cars.map((car) => car.name).toList();
    print("car names: $allCars");

    var newUser = new User(mapUser.name, mapUser.email);
    print("address: ${newUser.address}");
    expect(newUser.address, null);
    var newUserJson = newUser.toJson();
    print(newUserJson);
  });

  test("Test User Model", () {
    var user = new UserModel.fromJson(JSON.decode(json));
    print(user.toJson());

    print("name: ${user.name}");
    print("cars: ${user.cars}");
    print(user.cars.map((car) => car.name).toList());
  });

  test("Post Test", () async {
    var jsonData = {
      "deviceId": "bbf290c070d187014deb87e12a6c19",
    };
    var url = "http://whoopie.boxes.pw:3004/users/checkUserCountry";
    var httpClient = new HttpClient();
    var request = await httpClient.postUrl(Uri.parse(url))
      ..headers.contentType = ContentType.JSON
      ..write(JSON.encode(jsonData));
    var response = await request.close();
    print(response.statusCode);
    if (response.statusCode == HttpStatus.OK) {
      var json = response.transform(UTF8.decoder).join()
        ..then((result) {
          print("result: ${result}");
        });
    }
  });

  test("map api", () async {
    var mapAPI = "AIzaSyCFzP7IzWHR2V89Ii7EqYcBAgVQusx724o";
    var placeAPI = "AIzaSyC4VhGZhNyfz_hemDuT42J3mdMEGD6wQXE";

    var query = "kuala+lumpur+car+workshop";
    var mapURL =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=${query}&key=${mapAPI}";
    var nextPageToken =
        "CpQCAgEAAI4-fWqgxcI7iBzAviRGg3t1v0TGToifbkWGWF7_1nkjazGD_1P4NeKrG2R55qi9Cr3CFw5hZ4gezpEKSzR4HyrH9A5sOlHXMEylbtFIGJ6TNPBRVmm7kOBtKSx08ysM431ocCJ2q6t9kq0fdxxFEfRYySysESRH8ppWH0TfJ3H4VgvMNzI9lAzxZH_SIfE3irsUFPARdO_cYF85VlsznldCgDqdfDALRFyK7_BZz6wNLzjYEhfPzCzywK43dUGoV7luxmSYr6sHunXldeh-fgwx1lk94ZDEuGvlglSoU_lQggZqWXEEf6YXhS_M_FeCM2rWjmvHlmxs_pOTjsGMeEPyItUNpPW9imlrmiHcN_gzEhB4JvRWuC1A_KS4JtDnpUG9GhSX093knVEo23JqT41JxVZTc49wTA";
    var nextPageURL =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?pagetoken=${nextPageToken}&key=${mapAPI}";


    void _getPlace(String placeId) async {
      print("placeId: ${placeId}");
      var placeURL =
          "https://maps.googleapis.com/maps/api/place/details/json?placeid=${placeId}&key=${placeAPI}";
      var httpClient = new HttpClient();
      var request = await httpClient.getUrl(Uri.parse(placeURL));
      var response = await request.close();
      if(response.statusCode == HttpStatus.OK) {
        var json = await response.transform(UTF8.decoder).join();
        var result = new PlaceData.fromJson(JSON.decode(json));
        print("phone: ${result.result.formatted_phone_number}");
      } else {
        print("Invalid Request: ${response.statusCode}");
      }
    }

    var httpClient = new HttpClient();
    var request = await httpClient.getUrl(Uri.parse(mapURL));
    var response = await request.close();

    print(response.statusCode);
    print("HttpStatus.OK: ${HttpStatus.OK}");
    if (response.statusCode == HttpStatus.OK) {
      var json = await response.transform(UTF8.decoder).join();
      var result = new MapData.fromJson(JSON.decode(json));
      print("json: ${result.results.length}");
      print("placeId: ${result.results[0].place_id}");
      _getPlace(result.results[0].place_id);
    } else {
      print("Invalid Request: ${response.statusCode}");
    }

  });
}

class MapData {
  String next_page_token;
  List<MapResult> results;

  MapData.fromJson(Map<String, dynamic> json)
      : next_page_token = json["next_page_token"],
        results = (json["results"] as List)?.map((result) => result == null ? null : new MapResult.fromJson(result))?.toList();
}

class MapResult {
  String place_id;

  MapResult.fromJson(Map<String, dynamic> json) :
      place_id = json["place_id"];
}

class PlaceData {
  PlaceResult result;

  PlaceData.fromJson(Map<String, dynamic> json) :
        result = new PlaceResult.fromJson(json["result"]);
}

class PlaceResult {
  String formatted_address;
  String formatted_phone_number;

  PlaceResult.fromJson(Map<String, dynamic> json) :
        formatted_address = json["formatted_address"],
        formatted_phone_number = json["formatted_phone_number"];
}