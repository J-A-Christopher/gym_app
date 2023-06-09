import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TabContent extends StatelessWidget {
  const TabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sites = [
      'https://youtu.be/LWdhO_OMrHk',
      'https://youtu.be/Xg9B6pqHUQE',
      'https://youtu.be/jVabPEjDCHY',
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
                  'assets/leg.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            title: const Text('Sample Leg Exercise'),
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
