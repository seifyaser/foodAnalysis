import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/cubit/cubit/linking_ai_cuibit_cubit.dart';
import 'package:project/cubit/cubit/linking_ai_cuibit_state.dart';
import 'package:project/widgets/ImagePickerButoons.dart';
import 'package:project/widgets/bottomSheetDetails.dart';
import 'package:project/widgets/show_image_container.dart';

class MyHomePage extends StatelessWidget {
  void showFoodAnalysis(
    BuildContext context,
    Map<String, dynamic> nutritionData,
    List<String> ingredients,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return bottomSheetDetails(context, nutritionData, ingredients);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: BlocBuilder<LinkingAiCubit, LinkingAiState>(
          builder: (context, state) {
            Widget imageWidget;
            if (state is DescriptionReady) {
              imageWidget = ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  state.image,
                  width: 350,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              );
            } else {
              imageWidget = showEmptyImageContainer();
            }

            if (state is LinkingAiLoading) {
              return CircularProgressIndicator(color: Colors.greenAccent);
            } else if (state is DescriptionReady) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageWidget,
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showFoodAnalysis(
                          context,
                          state.nutritionData,
                          (state.nutritionData["ingredients"] as List<dynamic>)
                              .cast<String>(),
                        );
                      });
                    },
                    child: Text('Show Food Analysis'),
                  ),
                  const SizedBox(height: 12),
                  ImagePickerButtons(context),
                ],
              );
            } else if (state is LinkingAiError) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  const SizedBox(height: 12),
                  ImagePickerButtons(context),
                ],
              );
            } else {
              // initial or other states without image
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  imageWidget,
                  const SizedBox(height: 12),
                  ImagePickerButtons(context),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
