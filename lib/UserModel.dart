import 'package:json_annotation/json_annotation.dart';

part 'UserModel.g.dart';

@JsonSerializable()
class UserModel extends Object with _$UserModelSerializerMixin {

  String name;
  String email;
  String address;
  String gender;
  List<CarModel> cars;

  UserModel(this.name, this.email);

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

}

@JsonSerializable()
class CarModel extends Object with _$CarModelSerializerMixin {

  String name;

  CarModel(this.name);

  factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
}