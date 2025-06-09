import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/cubit/cubit/linking_ai_cuibit_state.dart';
import 'package:project/services/gemeni_Service.dart';

class LinkingAiCubit extends Cubit<LinkingAiState> {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  LinkingAiCubit() : super(LinkingAiInitial());

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);

        emit(ImagePicked(image: selectedImage!));
        await analyseImage();
      } else {
        emit(LinkingAiError(message: 'لم يتم اختيار صورة'));
      }
    } catch (e) {
      emit(LinkingAiError(message: e.toString()));
    }
  }

  Future<void> analyseImage() async {
    if (selectedImage == null) {
      emit(LinkingAiError(message: 'لا توجد صورة لتحليلها'));
      return;
    }

    emit(LinkingAiLoading());

    try {
      final Map<String, dynamic>? description = await GemeniService()
          .sendImageToGemini(selectedImage!, '''
Respond ONLY with a valid JSON object (no extra text, no explanation). The object should contain:
{
  "name": string,
  "calories": number,
  "protein": number,
  "carbs": number,
  "fat": number,
  "sugar": number,
  "ingredients": [list of strings],
  "health_score": number,  // from 0 to 100 representing how healthy the dish is
  "is_healthy": boolean    // true if the dish is generally considered healthy, false otherwise
}
For ingredients, provide only the names of the items (e.g. "olive oil", "onion") without quantities or measurements.
If unsure, return your best guess.
If you see image not realted to food, respond with "not food" in the "name" field.
Do NOT add any text before or after the JSON.
  ''');

      if (description != null) {
        emit(
          DescriptionReady(image: selectedImage!, nutritionData: description),
        );
      } else {
        emit(
          LinkingAiError(message: 'لم يتم تحليل الصورة بنجاح أو رد غير صالح'),
        );
      }
    } catch (e) {
      if (e.toString().contains('FormatException')) {
        emit(LinkingAiError(message: 'الرد من النموذج ليس JSON صالح.'));
      } else {
        emit(LinkingAiError(message: e.toString()));
      }
    }
  }
}
