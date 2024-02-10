import 'dart:io';

import 'package:divar_app/const.dart';
import 'package:divar_app/model/categoryModel.dart';
import 'package:divar_app/pages/addItem/bloc/additem_bloc.dart';
import 'package:divar_app/pages/addItem/bloc/additem_event.dart';
import 'package:divar_app/pages/addItem/bloc/additem_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late PageController _pageController;
  String _status = 'نو';
  final ImagePicker _picker = ImagePicker();
  List<File> _images = [];
  final ValueNotifier<int> _valueNotifier = ValueNotifier<int>(0);
  CategoryModel? categoryModel;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
    _pageController = PageController(viewportFraction: .8);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddItemBloc()..add(AddItemGetCategoryEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          title: Text(
            "اضافه کردن تبلیغ",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              WidgetConstant.customTextFeild(
                  _titleController, context, "عنوان"),
              WidgetConstant.customTextFeild(
                  _priceController, context, 'قیمت پیشنهادی'),
              WidgetConstant.customTextFeild(
                  _descriptionController, context, "توضیحات"),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "وضعیت",
                      style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    ),
                    PopupMenuButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.grey.shade200,
                      elevation: 0,
                      child: Row(
                        children: [
                          Text(
                            _status,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(
                            width: .5.w,
                          ),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                        ],
                      ),
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                            onTap: () {
                              _status = "نو";
                              setState(() {});
                            },
                            child: Center(
                              child: Text(
                                "نو",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: () {
                              _status = "قدیمی";
                              setState(() {});
                            },
                            child: Center(
                              child: Text(
                                "قدیمی",
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ),
                        ];
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.h),
                child: BlocBuilder<AddItemBloc, AddItemState>(
                  builder: (context, state) {
                    if (state is AddItemLoadingGetCategoryState) {
                      return Center(
                        child: WidgetConstant.loadingAnimation(8.w),
                      );
                    }
                    if (state is AddItemErrorGetCategoryState) {
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
                    if (state is AddItemResponseGetCategoryState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "دسته بندی",
                            style:
                                TextStyle(color: Colors.black, fontSize: 12.sp),
                          ),
                          PopupMenuButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.grey.shade200,
                            elevation: 0,
                            child: Row(
                              children: [
                                Text(
                                  categoryModel == null
                                      ? "انتخاب کنید:"
                                      : categoryModel!.name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: .5.w,
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            itemBuilder: (context) {
                              return state.category
                                  .map<PopupMenuItem>((e) => PopupMenuItem(
                                      onTap: () {
                                        categoryModel = e;
                                        setState(() {});
                                      },
                                      child: Center(
                                        child: Text(
                                          e.name,
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      )))
                                  .toList();
                            },
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 5.h),
                    backgroundColor: ColorConst.priamaryRedColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    List<XFile> imageLST = await _picker.pickMultiImage();
                    for (var element in imageLST) {
                      _images.add(File(element.path));
                    }

                    _valueNotifier.value = _images.length;
                    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                    _valueNotifier.notifyListeners();
                  },
                  child: const Text(
                    "انتخاب عکس",
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
                width: double.infinity,
                child: ValueListenableBuilder(
                    valueListenable: _valueNotifier,
                    builder: (context, value, child) {
                      if (value == 0) {
                        return Center(
                          child: Text(
                            "No Image",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                            ),
                          ),
                        );
                      }
                      return Stack(
                        children: [
                          PageView.builder(
                            itemCount: value,
                            controller: _pageController,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 1.5.h),
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      image: DecorationImage(
                                        image: FileImage(_images[index]),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  Positioned(
                                    right: 5,
                                    top: 8,
                                    child: IconButton(
                                      onPressed: () {
                                        _images.removeAt(index);
                                        _valueNotifier.value = _images.length;
                                        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                        _valueNotifier.notifyListeners();
                                      },
                                      icon: Icon(
                                        CupertinoIcons.trash_circle,
                                        size: 5.h,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                          Positioned(
                            bottom: 3.h,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: value,
                                effect: ColorTransitionEffect(
                                  dotColor: Colors.white,
                                  activeDotColor: ColorConst.priamaryRedColor,
                                  dotHeight: 1.5.h,
                                  dotWidth: 1.5.h,
                                  spacing: 6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
                child: BlocConsumer<AddItemBloc, AddItemState>(
                  listener: (context, state) {
                    if (state is AddItemErrorSumbitState) {
                      WidgetConstant.customSnakeBar(context, state.err);
                      return;
                    }

                    if (state is AddItemResponseSubmitState) {
                      WidgetConstant.customSnakeBar(context, state.response);
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is AddItemLoadingSumbitState) {
                      return Center(
                        child: WidgetConstant.loadingAnimation(8.w),
                      );
                    }

                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(50.w, 5.h),
                        backgroundColor: ColorConst.priamaryRedColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_titleController.text.trim().isEmpty) {
                          WidgetConstant.customSnakeBar(
                              context, "عنوان خالی است");
                          return;
                        }
                        if (_priceController.text.trim().isEmpty) {
                          WidgetConstant.customSnakeBar(
                              context, "قیمت خالی است");
                          return;
                        }
                        if (_descriptionController.text.trim().isEmpty) {
                          WidgetConstant.customSnakeBar(
                              context, "توضیحات خالی است");
                          return;
                        }
                        var price =
                            double.tryParse(_priceController.text.trim());
                        if (price == null) {
                          WidgetConstant.customSnakeBar(
                              context, "قیمت را درست وارد نکردین ");
                          return;
                        }

                        if (categoryModel == null) {
                          WidgetConstant.customSnakeBar(
                              context, "شما دسته بندی انتخاب نکردین ");
                          return;
                        }
                        if (categoryModel == null) {
                          WidgetConstant.customSnakeBar(
                              context, "شما دسته بندی انتخاب نکردین ");
                          return;
                        }
                        if (_images.length < 2) {
                          WidgetConstant.customSnakeBar(
                              context, "حداقل باید ۲ عکس انتخاب کنین ");
                          return;
                        }

                        BlocProvider.of<AddItemBloc>(context).add(
                          AddItemRequestAddEvent(
                            categoryId: categoryModel!.id,
                            title: _titleController.text.trim(),
                            price: _priceController.text.trim(),
                            description: _descriptionController.text.trim(),
                            status: _status,
                            images: _images,
                          ),
                        );
                      },
                      child: const Text(
                        "ثبت",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
