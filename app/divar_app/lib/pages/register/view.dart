import 'package:divar_app/const.dart';
import 'package:divar_app/pages/main/mainScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 2,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.black,
        shadowColor: Colors.black,
        title: Text(
          "وارد شوید",
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
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainScreen(),
                    ),
                    (route) => false);
              },
              child: Text(
                "ورود",
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
