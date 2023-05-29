import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/arms_provider.dart';
import '../widgets/chart_bar.dart';

class BarChartWidget1 extends StatefulWidget {
  const BarChartWidget1({super.key});

  @override
  State<BarChartWidget1> createState() => _BarChartWidget1State();
}

class _BarChartWidget1State extends State<BarChartWidget1> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ArmsProvider>(
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
