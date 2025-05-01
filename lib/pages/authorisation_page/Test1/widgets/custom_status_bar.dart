import 'package:flutter/material.dart';

class CustomStatusBar extends StatelessWidget {
  const CustomStatusBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      color: const Color(0xFF111827), // bg-gray-900
      child: Row(
        children: [
          const Text(
            '9:41',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(width: 40), // gap-10
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://cdn.builder.io/api/v1/image/assets/b1423cbfa6c248cab3761f8904db5422/0fecc14ac25d045147f561515b7c446b99f31102',
                  width: 17,
                  height: 10, // Aspect ratio 1.7
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 6), // gap-1.5
                Image.network(
                  'https://cdn.builder.io/api/v1/image/assets/b1423cbfa6c248cab3761f8904db5422/c63fce8acfb497517e20f241c1496db555062cc2',
                  width: 15,
                  height: 11, // Aspect ratio 1.36
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
