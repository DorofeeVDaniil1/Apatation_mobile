import 'package:flutter/material.dart';
import '../../widgets/top_menu.dart';

class MainPageWithMenu extends StatefulWidget {
  const MainPageWithMenu({super.key});

  @override
  State<MainPageWithMenu> createState() => _MainPageWithMenuState();
}

class _MainPageWithMenuState extends State<MainPageWithMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: const Color(0xFFF6F7FB),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 330,
              child: Container(
                color: const Color(0xFF0D1720),
                child: const TopMenu(
                  userName: 'Даниил',
                  userLevel: 1,
                  points: 100,
                ),
              ),
            ),
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
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 52, left: 30, right: 30),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: _buildMenuItems(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems() {
    final menuItems = [
      MenuItem('Ссылки', 'assets/images/attach.png',
          small: true, route: '/links'),
      MenuItem('Адрес', 'assets/images/location.png',
          small: true, route: '/address'),
      MenuItem('О нас', 'assets/images/people.png',
          small: true, route: '/about'),
      MenuItem('Пропускной режим', 'assets/images/mask-group.png',
          route: '/access'),
      MenuItem('Баллы', 'assets/images/points.png', route: '/points'),
      MenuItem('Инструкции', 'assets/images/instructions.png',
          route: '/instructions'),
      MenuItem('Документы', 'assets/images/documents.png', route: '/documents'),
    ];

    return menuItems.map((item) {
      return GestureDetector(
        onTap: () {
          if (item.route != null) {
            Navigator.pushNamed(context, item.route!);
          }
        },
        child: Container(
          width: item.small ? 100 : 170,
          height: item.small ? 100 : 129,
          decoration: BoxDecoration(
            color: const Color(0xFFEAEAEA),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                top: item.small ? 20 : 19,
                left: item.small ? 14 : 20,
                child: Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Image.asset(
                  item.iconPath,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                  width: item.small ? 43 : 41,
                  height: item.small ? 43 : 41,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

class MenuItem {
  final String title;
  final String iconPath;
  final bool small;
  final String? route;

  MenuItem(this.title, this.iconPath, {this.small = false, this.route});
}
