import 'package:divar_app/const.dart';
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
              title: const Text(
                "Title ss",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              pinned: true,
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  CupertinoIcons.back,
                  color: Colors.black,
                  size: 3.h,
                ),
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
                    Center(
                      child: Container(
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
                      ),
                    )
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "data",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "data",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      children: [
                        Text(
                          "data",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "data",
                          style: TextStyle(
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const Divider(),
                    SizedBox(
                      height: 1.h,
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "توضیحات",
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      "ldadadlaldaldlal lldaldlal lladlalll lal allslsllsdlldl dls lsl dlsl sl lsl dll sl dls ldl ldsl lsl",
                      style: TextStyle(
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.infinity,
          height: 10.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.4),
                  offset: const Offset(0, -1),
                  blurRadius: 4,
                  blurStyle: BlurStyle.inner),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Row(
            children: [
              Text(
                "شخصی که آگهی رو قرار داده :",
                style: TextStyle(
                  fontSize: 10.sp,
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConst.priamaryRedColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "پیام در چت",
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
