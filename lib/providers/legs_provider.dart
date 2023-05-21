import 'package:flutter/material.dart';
import './practice_provider.dart';
import 'package:intl/intl.dart';
import '../helpers/db_helper.dart';

class LegsProvider with ChangeNotifier {
  List<PracticeProvider> _legs = [];
  List<PracticeProvider> get legs {
    return [..._legs];
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
    _legs.add(practice);

    notifyListeners();
    DBHelper.insert('legs', {
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

      var smData = _legs.where((practice) {
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

  Future<void> fetchAndSetPractice() async {
    final dataList = await DBHelper.getData('legs');
    _legs = dataList
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
}
