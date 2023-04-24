import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/legs_provider.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LegsProvider>(
      builder: (context, notifier, child) {
        return Card(
          elevation: 6,
          margin: const EdgeInsets.all(20),
          child: Row(
              children: notifier.groupedWeight.map((data) {
            return Text('${data['day']}: ${data['weight']}');
          }).toList()),
        );
      },
    );
  }
}
