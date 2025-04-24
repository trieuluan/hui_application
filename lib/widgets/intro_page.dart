
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  final String title;
  final String description;
  final bool isLastPage;
  final VoidCallback onFinish;

  const IntroPage({
    super.key,
    required this.title,
    required this.description,
    required this.isLastPage,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 48),
          if (isLastPage)
            ElevatedButton(
              onPressed: onFinish,
              child: const Text('Bắt đầu ngay'),
            ),
        ],
      ),
    );
  }
}