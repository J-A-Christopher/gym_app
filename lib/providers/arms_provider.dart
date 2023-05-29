import 'package:flutter/material.dart';
import './practice_provider.dart';
import 'package:intl/intl.dart';
import '../helpers/db_arms.dart';

class ArmsProvider with ChangeNotifier {
  List<PracticeProvider> _arms = [];
  List<PracticeProvider> get arms {
    return [..._arms];
  }

  void addPractice(PracticeProvider newPractice) {
    var practice = PracticeProvider(
        kgs: newPractice.kgs,
        id: DateTime.now().toString(),
        reps: newPractice.reps,
        sets: newPractice.sets,
        subType: newPractice.subType,
        type: newPractice.type,
        time: DateTime.now());
    _arms.add(practice);

    notifyListeners();
    DBHelper1.insert('arms', {
      'id': practice.id,
      'type': practice.type,
      'subtype': practice.subType,
      'reps': practice.reps,
      'sets': practice.sets,
      'time': practice.time.toIso8601String(),
      'kgs': practice.kgs
    });
  }

  List<Map<String, dynamic>> get groupedWeight {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var smData = _arms.where((practice) {
        return practice.time
            .isAfter(DateTime.now().subtract(const Duration(days: 7)));
      }).toList();

      var totalWeight = 0.0;

      for (var i = 0; i < smData.length; i++) {
        if (smData[i].time.day == weekDay.day &&
            smData[i].time.month == weekDay.month &&
            smData[i].time.year == weekDay.year) {
          totalWeight += smData[i].kgs;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'weight': totalWeight
      };
    }).reversed.toList();
  }

  double get totalmaxWeight {
    return groupedWeight.fold(0.0, (sum, item) {
      return sum + item['weight'];
    });
  }

  Future<void> fetchAndSetPractice1() async {
    final dataList1 = await DBHelper1.getData('arms');
    _arms = dataList1
        .map((prac) => PracticeProvider(
            kgs: prac['kgs'],
            id: prac['id'],
            reps: prac['reps'],
            sets: prac['sets'],
            subType: prac['subtype'],
            type: prac['type'],
            time: DateTime.parse(prac['time'])))
        .toList();
    notifyListeners();
  }

  Future<void> deletePractice(String pracId) async {
    DBHelper1.deletePrac(pracId);
    fetchAndSetPractice1();
    notifyListeners();
  }
}
