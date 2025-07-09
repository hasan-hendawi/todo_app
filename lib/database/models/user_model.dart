import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  static const userCollectionName = "users";
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? email;

  UserModel({this.id, this.email, this.name});

  UserModel.fromJson(Map<String, dynamic>? data) : this(email: data?['email'], id: data?['id'], name: data?['name']);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'UserModel{id: $id, name: $name, email: $email}';
  }
}