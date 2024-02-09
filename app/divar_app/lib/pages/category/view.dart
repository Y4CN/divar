import 'package:divar_app/const.dart';
import 'package:divar_app/pages/archive/view.dart';
import 'package:divar_app/pages/category/bloc/category_bloc.dart';
import 'package:divar_app/pages/category/bloc/category_event.dart';
import 'package:divar_app/pages/category/bloc/category_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(CategoryRequestGetItemEvent()),
      child: Scaffold(
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
        body: BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoadingState) {
              return Center(
                child: WidgetConstant.loadingAnimation(8.w),
              );
            }
            if (state is CategoryErrorState) {
              return Center(
                child: Text(
                  state.err,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              );
            }
            if (state is CategoryResponseState) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArchiveScreen(categoryModel: state.categories[index],),
                              ));
                        },
                        title: Text(state.categories[index].name),
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
                            ],
                            image: DecorationImage(
                              image:
                                  NetworkImage(state.categories[index].image),
                              fit: BoxFit.contain,
                            ),
                          ),
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
    );
  }
}
