import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/cubit/cubit/linking_ai_cuibit_cubit.dart';

Widget ImagePickerButtons(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton.icon(
        onPressed: () => context.read<LinkingAiCubit>().pickImage(ImageSource.camera),
        icon: Icon(Icons.camera_alt),
        label: Text('Take Photo'),
      ),
      SizedBox(width: 16),
      ElevatedButton.icon(
        onPressed: () => context.read<LinkingAiCubit>().pickImage(ImageSource.gallery),
        icon: Icon(Icons.photo_library),
        label: Text('Pick from Gallery'),
      ),
    ],
  );
}
