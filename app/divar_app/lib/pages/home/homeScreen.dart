import 'package:divar_app/pages/single/singlePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.grey.shade200,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade200,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: .5.w, vertical: 1.h),
          child: TextField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            decoration: InputDecoration(
              hintText: "جستجو در همه آگهی ها",
              hintStyle: TextStyle(fontSize: 10.sp),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.grey.shade400,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
              sliver: SliverToBoxAdapter(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  spacing: 15,
                  children: getCategoryItems(),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 10,
                (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.only(bottom: 1.h, left: 2.w, right: 2.w),
                    child: SizedBox(
                      height: 13.h,
                      child: MaterialButton(
                        color: Colors.grey.shade200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 1.h),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SinglePage(),
                              ));
                        },
                        child: Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            children: [
                              Container(
                                height: 12.h,
                                width: 12.h,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "اسم محصول",
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "قیمت",
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                    Text(
                                      "زمان",
                                      style: TextStyle(
                                        fontSize: 9.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

List<Widget> getCategoryItems() {
  List<Widget> widgets = [];

  for (var i = 0; i < 11; i++) {
    widgets.add(
      Column(
        children: [
          Container(
            width: 14.w,
            height: 14.w,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/DivarLogo.png",
              height: 6.h,
            ),
          ),
          SizedBox(
            height: .5.h,
          ),
          Text(
            "اسم دسته بندی",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 7.sp,
            ),
          )
        ],
      ),
    );
  }

  return widgets;
}
