import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TabContent3 extends StatelessWidget {
  const TabContent3({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> sites = [
      'https://youtu.be/CqLo6br92dI',
      'https://youtu.be/dPb9JxFMuuE',
      'https://youtu.be/wAbsPbHW-d8',
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
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(
                  'assets/chest.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: const Text('Sample Chest Exercise'),
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
