import 'package:divar_app/pages/single/singlePage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({super.key});

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
          "Title",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 1,
              mainAxisSpacing: 8,
              childAspectRatio: .75,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     return const SinglePage();
                  //   },
                  // ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                  child: Column(
                    children: [
                      Container(
                        height: 20.h,
                        width: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Text(
                        "اسم",
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Text(
                        "time",
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        height: .5.h,
                      ),
                      Text(
                        "price",
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
