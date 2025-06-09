import 'package:flutter/widgets.dart';
import 'dart:io';


@immutable
abstract class LinkingAiState {}

class LinkingAiInitial extends LinkingAiState {}

class LinkingAiLoading extends LinkingAiState {}

class ImagePicked extends LinkingAiState {
  final File image;
  ImagePicked({required this.image});
}

class DescriptionReady extends LinkingAiState {
  final File image;
  final Map<String, dynamic> nutritionData; 
  DescriptionReady({required this.image, required this.nutritionData});
}


class LinkingAiError extends LinkingAiState {
  final String message;
  LinkingAiError({required this.message});
}
