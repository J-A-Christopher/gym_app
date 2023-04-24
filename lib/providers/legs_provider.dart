import 'package:flutter/material.dart';
import './practice_provider.dart';
import 'package:intl/intl.dart';

class LegsProvider with ChangeNotifier {
  //PracticeProvider _legs = PracticeProvider(kgs: 0.0, reps: 0, sets: 0, subType: '', type: '');
  final List<PracticeProvider> _legs = [
    // PracticeProvider(
    //     kgs: 23,
    //     id: DateTime.now().toString(),
    //     reps: 2,
    //     sets: 3,
    //     subType: 'Lower Leg',
    //     type: 'Leg',
    //     time: DateTime.now())
  ];
  List<PracticeProvider> get legs {
    return [..._legs];
  }

  List<Map<String, Object>> get groupedWeight {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalWeight = 0.0;
      if (_legs.isNotEmpty) {
        for (var i = 0; i <= _legs.length; i++) {
          if (_legs[i].time.day == weekDay.day &&
              _legs[i].time.month == weekDay.month &&
              _legs[i].time.month == weekDay.year) {
            totalWeight += _legs[i].kgs;
            print(totalWeight);
          }
        }
      }

      // print(DateFormat.E().format(weekDay));
      // print(totalWeight);

      return {'day': DateFormat.E().format(weekDay), 'weight': totalWeight};
    });
  }

  List<PracticeProvider> get _recentWeights {
    return _legs.where((lg) {
      return lg.time.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
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
    print(practice.time);
    notifyListeners();
  }
}
