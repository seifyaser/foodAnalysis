import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget PercentIndicatorshow(dynamic nutritionData) =>         CircularPercentIndicator(
  animation: true,
                          radius: 45.0,
                          lineWidth: 8.0,
                          percent: (nutritionData["health_score"] != null)
                              ? (nutritionData["health_score"] / 100)
                              : 0,
                          center: Text(
                            "${nutritionData["health_score"]?.toString() ?? "N/A"}%",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                          progressColor: const Color.fromARGB(255, 4, 202, 14),
                        );