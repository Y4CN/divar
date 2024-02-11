import 'package:divar_app/const.dart';
import 'package:divar_app/pages/search/bloc/search_bloc.dart';
import 'package:divar_app/pages/search/bloc/search_event.dart';
import 'package:divar_app/pages/search/bloc/search_state.dart';
import 'package:divar_app/pages/single/singlePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:sizer/sizer.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(),
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.grey.shade200,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.grey.shade200,
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: .2.w, vertical: 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Builder(
                    builder: (context) {
                      return TextField(
                        controller: _searchController,
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                        onSubmitted: (value) {
                          // BlocProvider.of<SearchBloc>(context).add(
                          //   SearchRequestEvent(_searchController.text.trim()),
                          // );
                          context.read<SearchBloc>().add( SearchRequestEvent(_searchController.text.trim()),);
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
                          prefixIcon: IconButton(
                            onPressed: () {
                              BlocProvider.of<SearchBloc>(context).add(
                                SearchRequestEvent(_searchController.text.trim()),
                              );
                            },
                            icon: Icon(
                              CupertinoIcons.search,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      );
                    }
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(CupertinoIcons.forward),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoadingState) {
                return Center(
                  child: WidgetConstant.loadingAnimation(8.w),
                );
              }
              if (state is SearchErrorState) {
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
              if (state is SearchResponseState) {
                return ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (context, index) {
                    DateTime currentTime =
                        DateTime.parse(state.items[index].createdAt);
                    final jalaliTime = currentTime.toJalali();
                    String heroTag = state.items[index].image;

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 1.h,
                        left: 2.w,
                        right: 2.w,
                      ),
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
                                  builder: (context) => SinglePage(
                                    itemid: state.items[index].id,
                                    heroTag: heroTag,
                                  ),
                                ));
                          },
                          child: Directionality(
                            textDirection: TextDirection.ltr,
                            child: Row(
                              children: [
                                Hero(
                                  tag: heroTag,
                                  child: Container(
                                    height: 12.h,
                                    width: 12.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade600,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            state.items[index].image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
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
                                        "${jalaliTime.year}/${jalaliTime.month}/${jalaliTime.day}  ${jalaliTime.hour}:${jalaliTime.minute}:${jalaliTime.second}",
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
                );
              }

              return Center(
                child: Text(
                  "سرچ کنین ... ",
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
