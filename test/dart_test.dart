import 'package:test/test.dart';

void main() {
  test('Test Singleton', () {
    var instanceA = new Singleton();
    print(instanceA.index);
    instanceA.index = 10;
    var instanceB = new Singleton();
    print(instanceB.index);
  });

  test('Test Maxins', () {
    var person = new Person();
    person.playMusic();
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

class Driver {
  bool canPlayPiano = false;
  playMusic() {
    print("no play");
  }
}

/*
Maxins - To implement a mixin, create a class that extends Object, declares no constructors, and has no calls to super
 */
class Person extends Object with Musical, Driver {
  Person() {
    print("Person");
  }
}