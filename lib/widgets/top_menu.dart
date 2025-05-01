import 'package:flutter/material.dart';

class TopMenu extends StatelessWidget {
  final String userName;
  final int userLevel;
  final int points;

  const TopMenu({
    super.key,
    required this.userName,
    required this.userLevel,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF0D1720),
      padding: const EdgeInsets.only(top: 29, left: 22, right: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // User profile section
          Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color(0xFFDDDDDD),
                    child: Icon(Icons.person),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFFCC00)),
                    ),
                    child: Text(
                      'Уровень $userLevel',
                      style: const TextStyle(
                        color: Color(0xFFFFCC00),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Text(
                userName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Points badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCC00),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/points_icon.png',
                  width: 27,
                  height: 27,
                ),
                const SizedBox(width: 8),
                Text(
                  points.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
