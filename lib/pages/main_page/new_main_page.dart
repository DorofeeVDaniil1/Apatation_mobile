// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'main_page.dart';
import '../tasks_page/tasks_page.dart';
import '../questions/questions_page.dart';
import '../profile/profile_page.dart';
import '../../design/colors.dart'; // Для использования yellow цвета
import '../links_page.dart';
import '../../widgets/top_menu.dart';
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
        home: const MainApp(),
      ),
    );
  }
}

// main_page.dart
class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _selectedIndex = 0;

  // Основные страницы, доступные через меню
  final List<Widget> _menuPages = const [
    MainPage(),
    TasksPage(),
    QuestionsPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });
    // Переход внутри вложенного Navigator:
    _navigatorKey.currentState!.pushReplacement(
      MaterialPageRoute(builder: (_) => _menuPages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (RouteSettings settings) {
          // Начальная страница соответствует выбранной вкладке меню
          return MaterialPageRoute(builder: (_) => _menuPages[_selectedIndex]);
        },
      ),
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

// Обновим MainPage
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context)
            .size
            .width, // Используем MediaQuery вместо фиксированных значений
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
                child: const TopMenu(
                  userName: 'Даниил',
                  userLevel: 1,
                  points: 100,
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
      MenuItem('Ссылки', 'assets/attach.png', small: true, route: '/links'),
      MenuItem('Адрес', 'assets/location.png', small: true, route: '/address'),
      MenuItem('О нас', 'assets/people.png', small: true, route: '/about'),
      MenuItem('Пропускной режим', 'assets/mask-group.png', route: '/access'),
      MenuItem('Баллы', 'assets/points.png', route: '/points'),
      MenuItem('Инструкции', 'assets/instructions.png', route: '/instructions'),
      MenuItem('Документы', 'assets/documents.png', route: '/documents'),
    ];

    return menuItems.map((item) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => _getPageForRoute(item.route),
            ),
          );
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

  Widget _getPageForRoute(String? route) {
    switch (route) {
      case '/links':
        return const LinksPage();
      // case '/address':
      //   return const AddressPage();
      // case '/about':
      //   return const AboutUsPage();
      // case '/access':
      //   return const AccessPage();
      // case '/points':
      //   return const PointsPage();
      // case '/instructions':
      //   return const InstructionsPage();
      // case '/documents':
      //   return const DocumentsPage();
      default:
        return const SizedBox.shrink();
    }
  }
}
