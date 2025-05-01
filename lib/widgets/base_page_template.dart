import 'package:flutter/material.dart';
import 'top_menu.dart';

class BasePageTemplate extends StatelessWidget {
  final Widget child;
  final String userName;
  final int userLevel;
  final int points;

  const BasePageTemplate({
    super.key,
    required this.child,
    this.userName = 'Даниил',
    this.userLevel = 1,
    this.points = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFF6F7FB),
        child: Stack(
          children: [
            // Header section with dark background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 330,
              child: Container(
                color: const Color(0xFF0D1720),
                child: TopMenu(
                  userName: userName,
                  userLevel: userLevel,
                  points: points,
                ),
              ),
            ),
            // Main content area
            Positioned(
              top: 124,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFDFDFE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                ),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
