import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/chest_provider.dart';
import '../widgets/chart_bar.dart';

class BarChartWidget3 extends StatelessWidget {
  const BarChartWidget3({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChestProvider>(
      builder: (context, notifier, child) {
        return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            elevation: 6,
            margin: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: notifier.groupedWeight
                      .map((data) => Flexible(
                            fit: FlexFit.tight,
                            child: ChartBar(
                                data['day'],
                                data['weight'],
                                notifier.totalmaxWeight == 0.0
                                    ? 0.0
                                    : (data['weight'] as double) /
                                        notifier.totalmaxWeight),
                          ))
                      .toList()),
            ));
      },
    );
  }
}
