import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TabContent2 extends StatelessWidget {
  const TabContent2({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sites = [
      'https://youtu.be/zgfc0WuTeYA',
      'https://youtu.be/8LJ3Q3Fsrzs',
      'https://youtu.be/tSMFXqIvMHY',
    ];

    return ListView.builder(
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/back.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text('Sample Back Exercise'),
            trailing: TextButton(
              onPressed: () {
                final Uri url = Uri.parse(sites[index]);
                Future<void> _launchUrl() async {
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                }

                _launchUrl();
              },
              child: const Text('Tap to View'),
            ),
          ),
        );
      },
      itemCount: sites.length,
    );
  }
}
