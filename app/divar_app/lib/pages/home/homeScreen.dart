import 'package:divar_app/const.dart';
import 'package:divar_app/model/categoryModel.dart';
import 'package:divar_app/pages/archive/view.dart';
import 'package:divar_app/pages/home/bloc/home_bloc.dart';
import 'package:divar_app/pages/home/bloc/home_event.dart';
import 'package:divar_app/pages/home/bloc/home_state.dart';
import 'package:divar_app/pages/single/singlePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeRequestAllDataEvent()),
      child: Scaffold(
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
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoadingState) {
                return Center(
                  child: WidgetConstant.loadingAnimation(8.w),
                );
              }
              if (state is HomeErrorState) {
                return Center(
                  child: Text(
                    state.error,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                  ),
                );
              }
              if (state is HomeResponseState) {
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      sliver: SliverToBoxAdapter(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          runSpacing: 10,
                          spacing: 15,
                          children: getCategoryItems(context, state.category),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: state.items.length,
                        (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                bottom: 1.h, left: 2.w, right: 2.w),
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
                                        builder: (context) =>
                                            const SinglePage(),
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
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(state.items[index].image),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              state.items[index].title,
                                              textAlign: TextAlign.end,
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              state.items[index].price,
                                              style: TextStyle(
                                                fontSize: 9.sp,
                                              ),
                                            ),
                                            Text(
                                              state.items[index].createdAt,
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

List<Widget> getCategoryItems(context, List<CategoryModel> categories) {
  List<Widget> widgets = [];

  for (var item in categories) {
    widgets.add(
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ArchiveScreen(),
              ));
        },
        child: Column(
          children: [
            Container(
                width: 14.w,
                height: 14.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(item.icon)),
            SizedBox(
              height: .5.h,
            ),
            Text(
              item.name,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 7.sp,
              ),
            )
          ],
        ),
      ),
    );
  }

  return widgets;
}
