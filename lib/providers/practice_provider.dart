import 'package:flutter/material.dart';

class PracticeProvider with ChangeNotifier {
  final String id;
  final String type;
  final String subType;
  final int reps;
  final int sets;
  final double kgs;
  final DateTime time;
  PracticeProvider(
      {required this.kgs,
      required this.id,
      required this.reps,
      required this.sets,
      required this.subType,
      required this.type,
      required this.time});
}
