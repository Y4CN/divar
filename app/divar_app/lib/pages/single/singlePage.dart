import 'package:divar_app/const.dart';
import 'package:divar_app/pages/single/bloc/single_bloc.dart';
import 'package:divar_app/pages/single/bloc/single_event.dart';
import 'package:divar_app/pages/single/bloc/single_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const imageNetwork = "https://www.w3schools.com/w3css/img_lights.jpg";

class SinglePage extends StatefulWidget {
  SinglePage({super.key, required this.itemid,this.heroTag});
  int itemid;
  String? heroTag;

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
    return BlocProvider(
      create: (context) => SingleBloc()..add(SingleRequestEvent(widget.itemid)),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<SingleBloc, SingleState>(
            builder: (context, state) {
              if (state is SingleLoadingState) {
                return Center(
                  child: WidgetConstant.loadingAnimation(8.w),
                );
              }
              if (state is SingleErrorState) {
                return Center(
                  child: Text(
                    state.err,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              if (state is SingleResponseState) {
                DateTime currentTime =
                    DateTime.parse(state.detailItemModel.itemsModel.createdAt);
                final jalaliTime = currentTime.toJalali();
                return Stack(
                  children: [
                    CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          elevation: 10,
                          shadowColor: Colors.grey,
                          foregroundColor: Colors.white,
                          surfaceTintColor: Colors.white,
                          title: Text(
                            state.detailItemModel.itemsModel.title,
                            style:
                                TextStyle(color: Colors.black, fontSize: 10.sp),
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
                                Hero(
                                  tag: widget.heroTag ?? "",
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount:
                                        state.detailItemModel.images.length,
                                    itemBuilder: (context, index) {
                                      return Image.network(
                                        state.detailItemModel.images[index]
                                            .image,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
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
                                        Text(
                                          state.detailItemModel.images.length
                                              .round()
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white),
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
                                      controller: _pageController,
                                      count:
                                          state.detailItemModel.images.length,
                                      effect: ColorTransitionEffect(
                                        dotColor: Colors.white,
                                        activeDotColor:
                                            ColorConst.priamaryRedColor,
                                        dotHeight: 1.5.h,
                                        dotWidth: 1.5.h,
                                        spacing: 6,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 3.w),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.detailItemModel.itemsModel.title,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "${jalaliTime.year}/${jalaliTime.month}/${jalaliTime.day}  ${jalaliTime.hour}:${jalaliTime.minute}:${jalaliTime.second}",
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
                                    padding:
                                        EdgeInsets.symmetric(vertical: 1.3.h),
                                    alignment: Alignment.center,
                                    child: Text(
                                      state.detailItemModel.itemsModel
                                          .categoryModel.name,
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
                                      state.detailItemModel.itemsModel.price,
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
                                      state.detailItemModel.status,
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
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  state.detailItemModel.description,
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
                          padding: EdgeInsets.only(bottom: 14.h),
                        ),
                      ],
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      right: 0,
                      child: SafeArea(
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
                                "${state.detailItemModel.itemsModel.userModel.name} آگهی رو قرار داده :",
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
                    ),
                  ],
                );
              }
              return Center(
                child: Text(
                  "out of Context ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.sp,
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
