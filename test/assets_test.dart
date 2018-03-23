import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/services.dart' show rootBundle;

void main() {
  testWidgets("Asset Bundle", (tester) async {
    print("asset bundle");
    Future<String> loadAsset() async {
      return await rootBundle.loadString("resources/detail.json");
    }

    var json = loadAsset();
    print("json: ${json.toString()}");
    json.then((data) {
      print("data: ${data}");
    })
    .catchError((error) {
      print("error: ${error.toString()}");
    })
    .whenComplete(() {
      print("complete");
    });
  });
}
