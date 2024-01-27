import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sizer/sizer.dart';

class ColorConst {
  ColorConst._();

  static Color priamaryRedColor = const Color(0xffA62426);
}

class WidgetConstant {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      customSnakeBar(context, String text) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: ColorConst.priamaryRedColor,
        content: Center(
          child: Text(
            text,
            style:  TextStyle(
              color: Colors.white,
              fontSize: 11.sp
            ),
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
}
