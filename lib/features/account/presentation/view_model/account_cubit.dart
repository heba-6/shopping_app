import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:shopping_app/core/networking/result_api.dart';
import 'package:shopping_app/features/account/domain/entities/user_profile_entity.dart';
import 'package:shopping_app/features/account/domain/use_case/get_user_profile_use_case.dart';
import 'package:shopping_app/features/account/domain/use_case/update_user_profile_use_case.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_state.dart';

@injectable
class AccountCubit extends Cubit<AccountState> {
  final GetUserProfileUseCase _getUserProfile;
  final UpdateUserProfileUseCase _updateUserProfile;

  final ImagePicker _imagePicker = ImagePicker();

  AccountCubit(this._getUserProfile, this._updateUserProfile)
    : super(const AccountState());

  Future<void> loadProfile() async {
    emit(state.copyWith(isLoading: true, clearError: true, clearSuccess: true));

    final result = await _getUserProfile();

    if (isClosed) return;

    if (result is Success<UserProfileEntity>) {
      emit(
        state.copyWith(
          isLoading: false,
          profile: result.data,
          clearError: true,
        ),
      );
    } else if (result is Error<UserProfileEntity>) {
      emit(state.copyWith(isLoading: false, errorMessage: result.messageError));
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (picked == null || isClosed) return;

      emit(
        state.copyWith(
          selectedImage: File(picked.path),
          clearError: true,
          clearSuccess: true,
        ),
      );
    } catch (error) {
      if (isClosed) return;

      emit(state.copyWith(errorMessage: 'Could not select image: $error'));
    }
  }

  Future<bool> saveProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    emit(
      state.copyWith(isUpdating: true, clearError: true, clearSuccess: true),
    );

    final result = await _updateUserProfile(
      name: name.trim(),
      phone: phone.trim(),
      address: address.trim(),
      image: state.profile?.image ?? '',
      imageFile: state.selectedImage,
    );

    if (isClosed) return false;

    if (result is Success<UserProfileEntity>) {
      emit(
        state.copyWith(
          isUpdating: false,
          profile: result.data,
          successMessage: 'Profile updated successfully.',
          clearSelectedImage: true,
          clearError: true,
        ),
      );

      return true;
    }

    if (result is Error<UserProfileEntity>) {
      emit(
        state.copyWith(isUpdating: false, errorMessage: result.messageError),
      );
    }

    return false;
  }

  void clearMessages() {
    emit(state.copyWith(clearError: true, clearSuccess: true));
  }
}
