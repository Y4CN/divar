import 'package:divar_app/const.dart';
import 'package:divar_app/pages/register/view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.priamaryRedColor,
                minimumSize: Size(10.w, 5.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {},
              child: Text(
                "ثبت نام",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
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
                    builder: (context) => const RegisterPage(),
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
    );
  }
}
