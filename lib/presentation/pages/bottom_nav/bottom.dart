import 'package:amar_bongo_app/presentation/constants/color.dart';
import 'package:amar_bongo_app/presentation/pages/favorite/favorite.dart';
import 'package:amar_bongo_app/presentation/pages/history/history.dart';
import 'package:amar_bongo_app/presentation/pages/home/home.dart';
import 'package:amar_bongo_app/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int selectedIndex = 0;
  final widgetOptions = const [
    HomePage(),
    FavoritePage(),
    HistoryPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: AppColor.blackColor.withOpacity(0.5),
        unselectedLabelStyle: const TextStyle(color: AppColor.goldenColor),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline), label: 'Favorite'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'Account'),
        ],
        currentIndex: selectedIndex,
        fixedColor: Theme.of(context).primaryColor,
        onTap: ((value) {
          setState(() {
            selectedIndex = value;
          });
        }),
      ),
    );
  }
}
