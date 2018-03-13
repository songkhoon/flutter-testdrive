// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserModel.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) =>
    new UserModel(json['name'] as String, json['email'] as String)
      ..address = json['address'] as String
      ..gender = json['gender'] as String
      ..cars = (json['cars'] as List)
          ?.map((e) => e == null
              ? null
              : new CarModel.fromJson(e as Map<String, dynamic>))
          ?.toList();

abstract class _$UserModelSerializerMixin {
  String get name;
  String get email;
  String get address;
  String get gender;
  List<CarModel> get cars;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'email': email,
        'address': address,
        'gender': gender,
        'cars': cars
      };
}

CarModel _$CarModelFromJson(Map<String, dynamic> json) =>
    new CarModel(json['name'] as String);

abstract class _$CarModelSerializerMixin {
  String get name;
  Map<String, dynamic> toJson() => <String, dynamic>{'name': name};
}
