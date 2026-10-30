import 'package:shopping_app/features/auth/domain/entities/login_response_entity.dart';

class LoginResponseDto {
  String? message;
  String? token;
  User? user;

  LoginResponseDto({this.message, this.token, this.user});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  LoginResponseEntity toEntity() =>
      LoginResponseEntity(message: message ?? "", token: token ?? "");
}

class User {
  String? name;
  String? phone;
  String? email;
  String? role;
  String? image;

  User({this.name, this.phone, this.email, this.role, this.image});
  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    role = json['role'];
    image = json['image'];
  }
}
