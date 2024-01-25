import 'package:divar_app/const.dart';
import 'package:divar_app/pages/archive/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

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
          "دسته بندی آگهی ها",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
          ),
        ),
      ),
      body: Expanded(
          child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ArchiveScreen(),
                      ));
                },
                title: const Text("data"),
                leading: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConst.priamaryRedColor,
                          offset: const Offset(1, 1),
                          blurRadius: 10,
                        )
                      ]),
                  alignment: Alignment.center,
                  child: const Icon(Icons.adb_sharp),
                ),
                trailing: const Icon(
                  CupertinoIcons.forward,
                ),
              ),
              Divider(
                height: 1.h,
                endIndent: 2.w,
                indent: 2.w,
              ),
            ],
          );
        },
      )),
    );
  }
}
