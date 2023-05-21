import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/legs_provider.dart';
import '../widgets/chart_bar.dart';

class BarChartWidget extends StatefulWidget {
  const BarChartWidget({super.key});

  @override
  State<BarChartWidget> createState() => _BarChartWidgetState();
}

class _BarChartWidgetState extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LegsProvider>(
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
