import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';

class UserProfileDto {
  final String name;
  final String phone;
  final String address;
  final String image;

  const UserProfileDto({
    required this.name,
    required this.phone,
    required this.address,
    required this.image,
  });

  factory UserProfileDto.fromJson(Map<String, dynamic> json) {
    final dynamic nested = json['data'] ?? json['user'] ?? json['message'];
    final Map<String, dynamic> user = nested is Map
        ? Map<String, dynamic>.from(nested)
        : json;

    return UserProfileDto(
      name: user['name']?.toString() ?? '',
      phone: user['phone']?.toString() ?? '',
      address: user['address']?.toString() ?? '',
      image: (user['image'] ?? user['avatar'] ?? '').toString(),
    );
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      name: name,
      phone: phone,
      address: address,
      image: image,
    );
  }
}
