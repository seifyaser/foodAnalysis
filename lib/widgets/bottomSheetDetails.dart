import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/widgets/NutritionDataColumn.dart';
import 'package:project/widgets/percentIndicator.dart';
import 'package:project/widgets/showFoodName.dart';

Widget bottomSheetDetails(
  BuildContext context,
  Map<String, dynamic> nutritionData,
  List<String> ingredients,
) => DraggableScrollableSheet(
  initialChildSize: 0.9,
  maxChildSize: 0.95,
  minChildSize: 0.5,
  builder: (context, controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.all(16),
      child: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ),
            Text(
              'Food Analysis',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShowNameFood(nutritionData),
                PercentIndicatorshow(nutritionData),
              ],
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: nutritionDataColumn(nutritionData),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📜 Ingredients",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ...ingredients.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Row(
                        children: [
                          Icon(Icons.circle, size: 6, color: Colors.white70),
                          SizedBox(width: 6),
                          Text(item, style: TextStyle(color: Colors.white70, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  },
);
