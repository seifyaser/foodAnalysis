import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/infoRow.dart';

Widget nutritionDataColumn(Map<String, dynamic> nutritionData) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nutritional Information",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          infoRow(
                            "Calories",
                            "${nutritionData["calories"]?.toString() ?? "N/A"} kcal",
                          ),
                          infoRow(
                            "Protein",
                            "${nutritionData["protein"]?.toString() ?? "N/A"} g",
                          ),
                          infoRow(
                            "Carbs",
                            "${nutritionData["carbs"]?.toString() ?? "N/A"} g",
                          ),
                          infoRow(
                            "Fat",
                            "${nutritionData["fat"]?.toString() ?? "N/A"} g",
                          ),
                          infoRow(
                            "Sugar",
                            "${nutritionData["sugar"]?.toString() ?? "N/A"} g",
                          ),
                        ],
                      );