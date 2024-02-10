import 'dart:ui';

import 'package:divar_app/const.dart';
import 'package:divar_app/pages/Register/bloc/Register_event.dart';
import 'package:divar_app/pages/Register/bloc/Register_state.dart';
import 'package:divar_app/pages/main/mainScreen.dart';
import 'package:divar_app/pages/login/view.dart';
import 'package:divar_app/pages/register/bloc/register_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  late final TextEditingController _userNameController;
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPassController;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
    _emailController = TextEditingController();
    _confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        title: Text(
          "ثبت نام کنین",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 10.sp,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => RegisterBloc(),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/DivarLogo.png",
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: TextField(
                    controller: _userNameController,
                    cursorColor: ColorConst.priamaryRedColor,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "نام کاربری",
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: TextField(
                    controller: _nameController,
                    cursorColor: ColorConst.priamaryRedColor,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "نام",
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: TextField(
                    controller: _emailController,
                    cursorColor: ColorConst.priamaryRedColor,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "ایمیل",
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: TextField(
                    controller: _passwordController,
                    cursorColor: ColorConst.priamaryRedColor,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "رمز عبور",
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: TextField(
                    controller: _confirmPassController,
                    cursorColor: ColorConst.priamaryRedColor,
                    onTapOutside: (event) {
                      FocusScope.of(context).unfocus();
                    },
                    style: TextStyle(color: Colors.black, fontSize: 12.sp),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: "تایید رمز عبور",
                      fillColor: Colors.grey.shade200,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterErrorState) {
                      WidgetConstant.customSnakeBar(context, state.error);
                      return;
                    }
                    if (state is RegisterResponseState) {
                      WidgetConstant.customSnakeBar(context, state.response);
                      _userNameController.clear();
                      _nameController.clear();
                      _emailController.clear();
                      _passwordController.clear();
                      _confirmPassController.clear();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                      return;
                    }
                  },
                  builder: (context, state) {
                    if (state is RegisterLoadingState) {
                      return Center(
                        child: WidgetConstant.loadingAnimation(6.h),
                      );
                    }
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.priamaryRedColor,
                        minimumSize: Size(10.w, 5.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (!EmailValidator.validate(
                            _emailController.text.trim())) {
                          WidgetConstant.customSnakeBar(
                              context, "ایمیل معتبر وارد کنید");
                          return;
                        }
                        if (_emailController.text.trim().isEmpty ||
                            _passwordController.text.trim().isEmpty) {
                          WidgetConstant.customSnakeBar(
                              context, "رمز عبور یا ایمیل را درست وارد کنید");
                          return;
                        }
                        if (_passwordController.text.trim() !=
                            _confirmPassController.text.trim()) {
                          WidgetConstant.customSnakeBar(
                              context, "باید رمز عبور و تایید رمز عبور یکی باشد");
                          return;
                        }
                        if (_passwordController.text.trim().length < 8) {
                          WidgetConstant.customSnakeBar(
                              context, "رمز عبور باید بیشتر از ۸ کاراکتر باشد");
                          return;
                        }
                        BlocProvider.of<RegisterBloc>(context).add(
                            RegisterRequestEvent(
                                _userNameController.text.trim(),
                                _nameController.text.trim(),
                                _emailController.text.trim(),
                                _passwordController.text.trim()));
                      },
                      child: Text(
                        "ثبت نام",
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      surfaceTintColor: ColorConst.priamaryRedColor,
                      foregroundColor: ColorConst.priamaryRedColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "اگر قبلا ثبت نام کردین اینجا کلیک کنین تا وارد شوید",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
