import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget ShowNameFood(dynamic nutritionData) =>   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nutritionData["name"]?.toString() ?? "N/A",
                      style: TextStyle(fontSize: 18, color: Colors.greenAccent),
                    ),
                    Text(
                      (nutritionData["is_healthy"] == true)
                          ? "Healthy"
                          : "Not Healthy",
                      style: TextStyle(
                        color:
                            (nutritionData["is_healthy"] == true)
                                ? Colors.green
                                : Colors.red,
                        fontSize: 16,
                      ),
                    ),
                  ],
                );