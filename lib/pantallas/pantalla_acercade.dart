import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PantallaAcercade extends StatelessWidget {
  const PantallaAcercade({super.key});
  final String githubUrl = 'https://github.com/dandresrp/pumiagenda';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Versión: 0.0.1',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Año: 2024',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _launchURL(githubUrl),
              child: Text(
                githubUrl,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Desarrolladores',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDeveloperCard('Foto Kaela'),
                _buildDeveloperCard('Foto Diego'),
                _buildDeveloperCard('Foto Roberto'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(String name) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          color: Colors.grey[300],
          child: Center(
            child: Text(
              name,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(name.split(' ')[1]),
      ],
    );
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}