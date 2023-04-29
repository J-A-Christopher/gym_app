import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double weightCarried;
  final double weightPercentageOfTotal;

  const ChartBar(this.label, this.weightCarried, this.weightPercentageOfTotal,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text(weightCarried.toStringAsFixed(2))),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 60,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(
                    220,
                    220,
                    220,
                    1,
                  ),
                ),
              ),
              FractionallySizedBox(
                heightFactor: weightPercentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
