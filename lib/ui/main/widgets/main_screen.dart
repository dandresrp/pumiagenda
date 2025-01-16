import 'package:flutter/material.dart';
import 'package:pumiagenda/ui/activities/widgets/activities_screen.dart';
import '../../home/widgets/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final currentPageIndex = ValueNotifier<int>(0);
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    currentPageIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: currentPageIndex,
        builder: (context, value, child) {
          final pages = [
            const HomeScreen(),
            const ActivitiesScreen(),
          ];
          return PageView(
            controller: pageController,
            onPageChanged: (index) {
              currentPageIndex.value = index;
            },
            children: pages,
          );
        },
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: currentPageIndex,
        builder: (context, value, child) => NavigationBar(
          onDestinationSelected: (int index) {
            currentPageIndex.value = index;
            pageController.jumpToPage(index);
          },
          selectedIndex: value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.note),
              label: 'Actividades',
            ),
          ],
        ),
      ),
    );
  }
}
