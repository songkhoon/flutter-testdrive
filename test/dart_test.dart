import 'package:test/test.dart';

void main() {
  test('Test Singleton', () {
    var instance1 = new Singleton();
    print(instance1.index);
    instance1.index = 10;
    var instance2 = new Singleton();
    print(instance2.index);

    var instance3 = new Singleton.empty();
    print(instance3.index);
    instance3.index = 88;
    var instance4 = new Singleton.empty();
    print(instance4.index);
  });

  test('Test Maxins', () {
    var person = new Person();
    person.playMusic();
    print("canPlayPiano: ${person.canPlayPiano}");
  });
}

class Singleton {
  static final Singleton _singleton = new Singleton._internal();
  int index;

  /*
  Factory Constructors, which effectively allows you to override the default behaviour when using the new keyword –
  instead of always creating a new instance the factory constructor is merely required to return an instance of the class
   */
  factory Singleton() {
    return _singleton;
  }

  factory Singleton.empty() {
    return new Singleton();
  }

  Singleton._internal() {
    index = 100;
  }
}

class Musical {
  bool canPlayPiano = true;
  playMusic() {
    print("play music");
  }
}

abstract class Driver {
  bool canPlayPiano = false;
  playMusic() {
    print("no play");
  }
}

/*
Maxins - To implement a mixin, create a class that extends Object, declares no constructors, and has no calls to super
 */
class Person extends Object with Driver, Musical {
  Person() {
    print("Person");
  }
}