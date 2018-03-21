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
    if(response.statusCode == HttpStatus.OK) {
      var json = response.transform(UTF8.decoder).join()
        ..then((result) {
          print("result: ${result}");
        });
    }

  });
}
