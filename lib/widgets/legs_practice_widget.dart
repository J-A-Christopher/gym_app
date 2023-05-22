import 'package:flutter/material.dart';
import '../providers/legs_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class LegsPracticeWidget extends StatelessWidget {
  const LegsPracticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<LegsProvider>(context, listen: false)
          .fetchAndSetPractice(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<LegsProvider>(builder: (context, notifier, ch) {
              return Expanded(
                child: ListView.builder(
                  itemBuilder: ((context, index) => SizedBox(
                        height: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          elevation: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Legs',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        notifier.legs[index].subType,
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                      Text(
                                        '${notifier.legs[index].reps}x${notifier.legs[index].sets}',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Text(
                                        '${notifier.legs[index].kgs} kg',
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                    'Date Modified:      ${DateFormat.yMMMEd().format(notifier.legs[index].time)} at ${DateFormat('h:mm a').format(notifier.legs[index].time)}')
                              ],
                            ),
                          ),
                        ),
                      )),
                  itemCount: notifier.legs.length,
                ),
              );
            }),
    );
  }
}
