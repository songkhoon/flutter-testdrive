class User {
  final String name;
  final String email;
  String address;
  String gender;
  List<Car> cars;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        address = json['address'],
        gender = json['gender'],
        cars = (json['cars'] as List)?.map((car) => car == null ? null : new Car.fromJson(car))?.toList()
  ;

  Map<String, dynamic> toJson() => {'name': name, 'email': email, 'address': address};
}

class Car {
  String name;
  int year;

  Car.fromJson(Map<String, dynamic> json)
  :name = json["name"]
  ;

  Map<String, dynamic> toJson() => {'name': name};

}