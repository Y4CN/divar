import 'package:divar_app/const.dart';
import 'package:divar_app/model/categoryModel.dart';
import 'package:divar_app/pages/archive/bloc/archive_bloc.dart';
import 'package:divar_app/pages/archive/bloc/archive_event.dart';
import 'package:divar_app/pages/archive/bloc/archive_state.dart';
import 'package:divar_app/pages/single/singlePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sizer/sizer.dart';

class ArchiveScreen extends StatefulWidget {
  ArchiveScreen({super.key, required this.categoryModel});
  CategoryModel categoryModel;

  @override
  State<ArchiveScreen> createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ArchiveBloc()
        ..add(ArchiveRequestEvent(catId: widget.categoryModel.id)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          title: Text(
            widget.categoryModel.name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
        ),
        body: SafeArea(
          child: BlocBuilder<ArchiveBloc, ArchiveState>(
            builder: (context, state) {
              if (state is ArchiveLoadingState) {
                return Center(
                  child: WidgetConstant.loadingAnimation(8.w),
                );
              }
              if (state is ArchiveErrorState) {
                return Center(
                  child: Text(
                    state.err,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  ),
                );
              }
              if (state is ArchiveResponseState) {
                if (state.items.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Date",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: .65,
                    ),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      DateTime currentTime =
                          DateTime.parse(state.items[index].createdAt);
                      final jalaliTime = currentTime.toJalali();

                      final heroTag = state.items[index].image;

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return SinglePage(
                                itemid: state.items[index].id,
                                heroTag: heroTag,
                              );
                            },
                          ));
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 2.w, vertical: 1.h),
                          child: Column(
                            children: [
                              Hero(
                                tag: heroTag,
                                child: Container(
                                  height: 20.h,
                                  width: 20.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          state.items[index].image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: .5.h,
                              ),
                              Text(
                                state.items[index].title,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: .5.h,
                              ),
                              Text(
                                "${jalaliTime.year}/${jalaliTime.month}/${jalaliTime.day}  ${jalaliTime.hour}:${jalaliTime.minute}:${jalaliTime.second}",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                height: .5.h,
                              ),
                              Text(
                                state.items[index].price,
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
