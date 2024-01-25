import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        title: Text(
          "پروفایل",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 2.h,
          ),
          Center(
            child: CircleAvatar(
              minRadius: 10.w,
              maxRadius: 10.w,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "USER NAME",
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "NAME",
            style: TextStyle(
              fontSize: 10.sp,
            ),
          ),
          SizedBox(
            height: 10.h,
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            onTap: () {},
            trailing: const Icon(
              CupertinoIcons.forward,
            ),
            title: Text(
              "تنظیمات",
              style: TextStyle(fontSize: 9.sp),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout_rounded),
            onTap: () {},
            trailing: const Icon(
              CupertinoIcons.forward,
            ),
            title: Text(
              "خروج",
              style: TextStyle(fontSize: 9.sp),
            ),
          ),
        ],
      ),
    );
  }
}
