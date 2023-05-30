import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TabContent1 extends StatelessWidget {
  const TabContent1({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sites = [
      'https://youtu.be/rdaIUhFWCpg',
      'https://youtu.be/prJ7vF2wx6A',
      'https://youtu.be/kiI57DPH3fM',
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
                  'assets/arm.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text('Sample Arm Exercise'),
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
