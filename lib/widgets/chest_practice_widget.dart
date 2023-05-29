import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/chest_provider.dart';

class ChestPracticeWidget extends StatelessWidget {
  const ChestPracticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ChestProvider>(context, listen: false)
          .fetchAndSetPractice1(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<ChestProvider>(builder: (context, notifier, ch) {
              return notifier.chest.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 150.0),
                        child: Text(
                          'Nothing to display...\nTap the plus button to add your practice',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemBuilder: ((context, index) => SizedBox(
                              height: 100,
                              child: Dismissible(
                                onDismissed: (direction) {
                                  Provider.of<ChestProvider>(context,
                                          listen: false)
                                      .deletePractice(notifier.chest[index].id);
                                },
                                key: UniqueKey(),
                                background: Container(
                                  padding: const EdgeInsets.only(right: 20),
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (drection) {
                                  return showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                            title: const Text('Are You Sure?'),
                                            content: const Text(
                                                'Do you want to delete ! !'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(false);
                                                  },
                                                  child: const Text('NO')),
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(true);
                                                  },
                                                  child: const Text('YES')),
                                            ],
                                          ));
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Chest',
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
                                                notifier.chest[index].subType,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                '${notifier.chest[index].reps}x${notifier.chest[index].sets}',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                '${notifier.chest[index].kgs} kg',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                            'Date Modified:      ${DateFormat.yMMMEd().format(notifier.chest[index].time)} at ${DateFormat('h:mm a').format(notifier.chest[index].time)}')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        itemCount: notifier.chest.length,
                      ),
                    );
            }),
    );
  }
}
