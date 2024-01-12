import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const imageNetwork = "https://www.w3schools.com/w3css/img_lights.jpg";

class SinglePage extends StatelessWidget {
  const SinglePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              automaticallyImplyLeading: false,
              leading: Icon(
                CupertinoIcons.back,
                color: Colors.black,
                size: 3.h,
              ),
              backgroundColor: Colors.white,
              expandedHeight: 30.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  imageNetwork,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "مثلا مبلمان رایان",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "مثلا نیم ساعت پیش در  اصفهان",
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1000),
                        color: Colors.grey.shade200,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 1.3.h),
                      alignment: Alignment.center,
                      child: Text(
                        "مثلا جزو وسایل خانگی",
                        style: TextStyle(
                          fontSize: 8.sp,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
