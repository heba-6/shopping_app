import 'dart:io';

import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';

class AccountState {
  final bool isLoading;
  final bool isUpdating;
  final UserProfileEntity? profile;
  final File? selectedImage;
  final String? errorMessage;
  final String? successMessage;

  const AccountState({
    this.isLoading = false,
    this.isUpdating = false,
    this.profile,
    this.selectedImage,
    this.errorMessage,
    this.successMessage,
  });

  AccountState copyWith({
    bool? isLoading,
    bool? isUpdating,
    UserProfileEntity? profile,
    File? selectedImage,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
    bool clearSelectedImage = false,
  }) {
    return AccountState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      profile: profile ?? this.profile,
      selectedImage: clearSelectedImage
          ? null
          : selectedImage ?? this.selectedImage,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      successMessage:
          clearSuccess ? null : successMessage ?? this.successMessage,
    );
  }
}