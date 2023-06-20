import 'package:flutter/material.dart';
import 'package:shapeup/screens/trainer/trainerscreen/chatRoomScreen.dart';
import 'package:shapeup/screens/trainer/trainerscreen/trainer_dashboard.dart';
import 'package:shapeup/screens/trainer/trainerscreen/trainernotfication.dart';
import 'package:shapeup/screens/trainer/trainerscreen/workoutplan.dart';

class TrainerPage extends StatefulWidget {
  const TrainerPage({Key? key}) : super(key: key);

  @override
  State<TrainerPage> createState() => _TrainerPageState();
}

class _TrainerPageState extends State<TrainerPage> {
  final List<Widget> screens = [
    const HomePageT(),
    const TrainerNotify(),
    const ChatRoomScreen(),
    const WorkoutPlan(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 28, 28, 30),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 3,
        backgroundColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.notifications),
            icon: Icon(Icons.notifications_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.message),
            icon: Icon(Icons.message_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.run_circle),
            icon: Icon(Icons.run_circle_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      body: SafeArea(
        child: screens[_selectedIndex],
      ),
    );
  }
}
