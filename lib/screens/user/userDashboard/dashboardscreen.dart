import 'package:flutter/material.dart';
import 'package:shapeup/screens/dietscreen.dart';
import 'package:shapeup/screens/exercisescreen.dart';
import 'package:shapeup/screens/user/userDashboard/homescreen.dart';
import 'package:shapeup/screens/notificationscreen.dart';
import 'package:shapeup/screens/premiumscreen.dart';

class DashBoardScreen extends StatefulWidget {
  final int? selectedIndex;
  const DashBoardScreen({Key? key, this.selectedIndex}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState() {
    setSelectedIndex();
    super.initState();
  }

  final List<Widget> screens = [
    const HomeScreen(),
    const ExerciseScreen(),
    const DietScreen(),
    const NotificationScreen(),
    const PremiumScreen(),
  ];
  int _selectedIndex = 0;

  setSelectedIndex() {
    setState(() {
      _selectedIndex = widget.selectedIndex ?? 0;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromARGB(255, 28, 28, 30),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 10,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.run_circle,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.run_circle_outlined,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.food_bank,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.food_bank_outlined,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.monetization_on,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.monetization_on_outlined,
              color: Colors.white,
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
    );
  }
}
