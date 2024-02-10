import 'package:divar_app/const.dart';
import 'package:divar_app/pages/addItem/view.dart';
import 'package:divar_app/pages/category/view.dart';
import 'package:divar_app/pages/chat/view.dart';
import 'package:divar_app/pages/home/homeScreen.dart';
import 'package:divar_app/pages/profile/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: indexPage,
        children: const [
          HomeScreen(),
          CategoryScreen(),
          ChatScreen(),
          ProfileScreen()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddItemPage(),
            ),
          );
        },
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
        backgroundColor: Colors.redAccent,
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: indexPage,
        onTap: (value) {
          setState(() {
            indexPage = value;
          });
        },
        selectedIconTheme: const IconThemeData(
          color: Colors.black,
          size: 25,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
          size: 20,
        ),
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10.sp,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
            ),
            label: "خانه",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_open_rounded,
            ),
            label: "دسته بندی",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.chat_bubble_fill,
            ),
            label: "چت",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: "پروفایل",
          ),
        ],
      ),
    );
  }
}
