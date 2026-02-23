import 'package:flutter/material.dart';
import 'package:projecto_registagro/view/pages/MyOrders/my_orders.dart';
import 'package:projecto_registagro/view/pages/Store/incialStore/inicial_store.dart';
import 'package:projecto_registagro/view/pages/main_page/home_screen/home_state.dart';
import 'package:projecto_registagro/view/pages/userProfile/profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;

  final List<Widget> screens = const [
    HomeState(),
    InicialStore(),
    MyOrderScreen(),
    ProfileState(),
  ];

  @override
  void initState() {
    super.initState();
    //_loadToken();

    tabController = TabController(
      length: screens.length,
      vsync: this,
      initialIndex: selectedIndex,
    );

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          selectedIndex = tabController.index;
        });
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
      tabController.animateTo(index);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: screens,
        ),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.white,
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: const Color(0xFFF6F6F6),
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Inter'),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
            BottomNavigationBarItem(
              icon: Icon(Icons.online_prediction_rounded),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outlined),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
