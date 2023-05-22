import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonTest extends StatelessWidget {
  const ButtonTest({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://youtu.be/oPoMLfjU-Ng');

    Future<void> _launchUrl() async {
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Center(
      child:
          ElevatedButton(onPressed: _launchUrl, child: const Text('Click me')),
    );
  }
}
