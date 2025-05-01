import 'package:flutter/material.dart';
import '../widgets/base_page_template.dart';

class LinksPage extends StatelessWidget {
  const LinksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePageTemplate(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Страница ссылок'),
            // Добавьте здесь свой контент
          ],
        ),
      ),
    );
  }
}
