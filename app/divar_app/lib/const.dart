import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ColorConst {
  ColorConst._();

  static Color priamaryRedColor = const Color(0xffA62426);
}

class UrlConst {
  UrlConst._();

  static String host = Platform.isAndroid ?"http://10.0.2.2:3000/api/v1/": "http://localhost:3000/api/v1/";
}

class WidgetConstant {
  WidgetConstant._();

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      customSnakeBar(context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConst.priamaryRedColor,
        content: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 11.sp),
          ),
        ),
      ),
    );
  }

  static Widget loadingAnimation(double size) {
    return LoadingAnimationWidget.staggeredDotsWave(
      color: ColorConst.priamaryRedColor,
      size: size,
    );
  }

  static Widget customTextFeild(TextEditingController controller, context,String hintText) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      child: TextField(
        controller: controller,
        cursorColor: ColorConst.priamaryRedColor,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        style: TextStyle(color: Colors.black, fontSize: 12.sp),
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: hintText,
          fillColor: Colors.grey.shade200,
          filled: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
