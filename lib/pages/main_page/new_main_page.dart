// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_page.dart';
import '../tasks_page/tasks_page.dart';
import '../questions/questions_page.dart';
import '../profile/profile_page.dart';
import '../../design/colors.dart';
import '../links_page.dart';
import '../../widgets/top_menu.dart';
import '../../widgets/base_page_template.dart';
// import '../address_page.dart';
// import '../about_us_page.dart';
// import '../access_page.dart';
// import '../points_page.dart';
// import '../instructions_page.dart';
// import '../documents_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainApp(),
          '/links': (context) => BasePageTemplate(
                showBackButton: true,
                child: const Text('Ссылки'),
              ),
          '/address': (context) => BasePageTemplate(
                showLogo: true,
                child: const Text('Адрес'),
              ),
          '/about': (context) => BasePageTemplate(
                showLogo: true,
                child: const Text('О нас'),
              ),
          '/access': (context) => const BasePageTemplate(
                child: Text('Пропускной режим'),
              ),
          '/points': (context) => const BasePageTemplate(
                child: Text('Баллы'),
              ),
          '/instructions': (context) => const BasePageTemplate(
                child: Text('Инструкции'),
              ),
          '/documents': (context) => const BasePageTemplate(
                child: Text('Документы'),
              ),
        },
        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Страница не найдена')),
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _menuPages = const [
    MainPage(),
    TasksPage(),
    QuestionsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _menuPages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        height: 70,
        selectedIndex: _selectedIndex,
        backgroundColor: Colors.white,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: CircleAvatar(
              backgroundColor: yellow,
              child: Icon(Icons.home, color: Colors.white),
            ),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.task_outlined),
            selectedIcon: CircleAvatar(
              backgroundColor: yellow,
              child: Icon(Icons.task, color: Colors.white),
            ),
            label: 'Задачи',
          ),
          NavigationDestination(
            icon: Icon(Icons.question_answer),
            selectedIcon: CircleAvatar(
              backgroundColor: yellow,
              child: Icon(Icons.question_answer, color: Colors.white),
            ),
            label: 'Вопросы',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_outlined),
            selectedIcon: CircleAvatar(
              backgroundColor: yellow,
              child: Icon(Icons.account_circle, color: Colors.white),
            ),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

class MenuItem {
  final String title;
  final String iconPath;
  final bool small;
  final String? route;

  MenuItem(this.title, this.iconPath, {this.small = false, this.route});
}

class NavItem {
  final String title;
  final String iconPath;
  final bool active;

  NavItem(this.title, this.iconPath, this.active);
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BasePageTemplate(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 52, left: 30, right: 30),
        child: Wrap(
          spacing: 20,
          runSpacing: 20,
          children: _buildMenuItems(),
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
