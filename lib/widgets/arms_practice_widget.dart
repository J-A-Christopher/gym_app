import 'package:flutter/material.dart';
import '../providers/arms_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ArmsPracticeWidget extends StatelessWidget {
  const ArmsPracticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ArmsProvider>(context, listen: false)
          .fetchAndSetPractice1(),
      builder: (context, snapshot) => snapshot.connectionState ==
              ConnectionState.waiting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<ArmsProvider>(builder: (context, notifier, ch) {
              return notifier.arms.isEmpty
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
                                  Provider.of<ArmsProvider>(context,
                                          listen: false)
                                      .deletePractice(notifier.arms[index].id);
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
                                          'Arms',
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
                                                notifier.arms[index].subType,
                                                style: const TextStyle(
                                                    fontSize: 15),
                                              ),
                                              Text(
                                                '${notifier.arms[index].reps}x${notifier.arms[index].sets}',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                              Text(
                                                '${notifier.arms[index].kgs} kg',
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                            'Date Modified:      ${DateFormat.yMMMEd().format(notifier.arms[index].time)} at ${DateFormat('h:mm a').format(notifier.arms[index].time)}')
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                        itemCount: notifier.arms.length,
                      ),
                    );
            }),
    );
  }
}
