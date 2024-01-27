import 'package:divar_app/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const imageNetwork = "https://www.w3schools.com/w3css/img_lights.jpg";

class SinglePage extends StatefulWidget {
  const SinglePage({super.key});

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              elevation: 10,
              shadowColor: Colors.grey,
              foregroundColor: Colors.white,
              surfaceTintColor: Colors.white,
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
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Image.network(
                          imageNetwork,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    Positioned(
                      left: 2.w,
                      bottom: 2.h,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: .5.h,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "2",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Icon(
                              Icons.window,
                              color: Colors.white,
                              size: 2.5.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 2.h,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: SmoothPageIndicator(
                          controller: _pageController, // PageController
                          count: 6,
                          effect: ColorTransitionEffect(
                            dotColor: Colors.white,
                            activeDotColor: ColorConst.priamaryRedColor,
                            dotHeight: 1.5.h,
                            dotWidth: 1.5.h,
                            spacing: 6,
                          ), // your preferred effect
                        ),
                      ),
                    ),
                  ],
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
                          "قیمت",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "۱۰۰۰۰",
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
                          "وضعیت",
                          style: TextStyle(
                            fontSize: 12.sp,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "در حد نو",
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
                      "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد، کتابهای زیادی در شصت و سه درصد گذشته حال و آینده، شناخت فراوان جامعه و متخصصان را می طلبد، تا با نرم افزارها شناخت بیشتری را برای طراحان رایانه ای علی الخصوص طراحان خلاقی، و فرهنگ پیشرو در زبان فارسی ایجاد کرد، در این صورت می توان امید داشت که تمام و دشواری موجود در ارائه راهکارها، و شرایط سخت تایپ به پایان رسد و زمان مورد نیاز شامل حروفچینی دستاوردهای اصلی، و جوابگوی سوالات پیوسته اهل دنیای موجود طراحی اساسا مورد استفاده قرار گیرد.",
                      style: TextStyle(
                        fontSize: 10.sp,
                        wordSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 5.h),
            ),
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
