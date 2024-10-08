import 'package:flutter/material.dart';

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
              child: Text(
                githubUrl,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 3, 4, 4),
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
        Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 8),
        // Mostrar el nombre debajo de la imagen
        Text(name),
      ],
    );
  }
}
