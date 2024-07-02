import 'package:flutter/material.dart';

class BottomNavBarWidget {
  static BottomNavigationBar bottomNavBar(Size screenSize, BuildContext context,
      int currentPageIndexValue, Function(int)? e) {
    return BottomNavigationBar(
      showUnselectedLabels: true,
      unselectedItemColor: const Color.fromARGB(255, 122, 121, 121),
      selectedItemColor: Colors.blue,
      showSelectedLabels: true,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      iconSize: screenSize.height * 0.035,
      currentIndex: currentPageIndexValue,
      onTap: e,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list,
          ),
          label: 'Customers',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.record_voice_over,
          ),
          label: 'Invoices',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.business,
          ),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_2_outlined,
          ),
          label: 'Account',
        ),
      ],
    );
  }
}
