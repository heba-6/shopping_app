import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_cubit.dart';
import 'package:shopping_app/features/account/presentation/view_model/account_state.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        final File? selectedImage = state.selectedImage;
        final String imageUrl = state.profile?.image ?? '';

        ImageProvider? imageProvider;

        if (selectedImage != null) {
          imageProvider = FileImage(selectedImage);
        } else if (imageUrl.startsWith('http')) {
          imageProvider = NetworkImage(imageUrl);
        }

        return Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: imageProvider,
              child: imageProvider == null
                  ? const Icon(
                      Icons.person_outline,
                      size: 55,
                      color: Colors.grey,
                    )
                  : null,
            ),
            TextButton.icon(
              onPressed: () => _showImageOptions(context),
              icon: const Icon(Icons.camera_alt_outlined),
              label: const Text('Change profile photo'),
            ),
          ],
        );
      },
    );
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<AccountCubit>().pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take a photo'),
                onTap: () {
                  Navigator.pop(sheetContext);
                  context.read<AccountCubit>().pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}