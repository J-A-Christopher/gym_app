import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/back_provider.dart';

class BackPracticeWidget extends StatelessWidget {
  const BackPracticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<BackProvider>(context, listen: false)
          .fetchAndSetPractice1(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<BackProvider>(builder: (context, notifier, ch) {
              return notifier.back.isEmpty
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
                                  Provider.of<BackProvider>(context,
                                          listen: false)
                                      .deletePractice(notifier.back[index].id);
                                },
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
                                key: UniqueKey(),
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
                                          'Back',
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
                                                notifier.back[index].subType,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                '${notifier.back[index].reps}x${notifier.back[index].sets}',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                '${notifier.back[index].kgs} kg',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                            'Date Modified:      ${DateFormat.yMMMEd().format(notifier.back[index].time)} at ${DateFormat('h:mm a').format(notifier.back[index].time)}')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        itemCount: notifier.back.length,
                      ),
                    );
            }),
    );
  }
}
