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
    // print(practice.kgs);

    notifyListeners();
  }

  // List<PracticeProvider> get _recentPractice {
  //   return _legs.where((practice) {
  //     return practice.time
  //         .isAfter(DateTime.now().subtract(const Duration(days: 7)));
  //   }).toList();
  // }

  List<Map<String, dynamic>> get groupedWeight {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var smData = _legs.where((practice) {
        return practice.time
            .isAfter(DateTime.now().subtract(const Duration(days: 7)));
      }).toList();

      var totalWeight = 0.0;
      print('smep${smData.first.kgs}');

      for (var i = 0; i < smData.length; i++) {
        if (smData[i].time.day == weekDay.day &&
            smData[i].time.month == weekDay.month &&
            smData[i].time.year == weekDay.year) {
          totalWeight += smData[i].kgs;

          //print('pop$totalWeight');
        }
      }
      print('haxm$totalWeight');
      // notifyListeners();

      // print(DateFormat.E().format(weekDay));
      // print(totalWeight);

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
}
