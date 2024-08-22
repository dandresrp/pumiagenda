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
            const Text(
              'Repositorio:',
              style: TextStyle(fontSize: 18),
            ),
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
              children: [
                Expanded(
                  child: _buildDeveloperCard(
                    'assets/images/Kaela.jpg',
                    'Kaela',
                  ),
                ),
                Expanded(
                  child: _buildDeveloperCard(
                    'assets/images/Diego.jpg',
                    'Diego',
                  ),
                ),
                Expanded(
                  child: _buildDeveloperCard(
                    'assets/images/Roberto.jpg',
                    'Roberto',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeveloperCard(String imagePath, String name) {
    return Column(
      children: [
        // Mostrar la imagen en un círculo
        Image.asset(
          imagePath,
          width: 30,
          height: 30,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        // Mostrar el nombre debajo de la imagen
        Text(name),
      ],
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'NO SE PUDO INICIAR $url';
    }
  }
}
