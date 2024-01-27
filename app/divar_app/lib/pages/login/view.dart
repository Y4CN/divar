import 'package:divar_app/const.dart';
import 'package:divar_app/pages/login/bloc/login_bloc.dart';
import 'package:divar_app/pages/login/bloc/login_event.dart';
import 'package:divar_app/pages/login/bloc/login_state.dart';
import 'package:divar_app/pages/main/mainScreen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<LoginPage> {
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
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
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
            children: [
              const Spacer(),
              Image.asset(
                "assets/images/DivarLogo.png",
                height: 10.h,
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
              SizedBox(
                height: 2.h,
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginResponseState) {
                    WidgetConstant.customSnakeBar(context, state.response);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                        (route) => false);
                    return;
                  }
                  if (state is LoginErrorState) {
                    WidgetConstant.customSnakeBar(context, state.response);
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoadingState) {
                    return Center(
                      child: WidgetConstant.loadingAnimation(8.h),
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
                      if (_passwordController.text.trim().length < 8) {
                        WidgetConstant.customSnakeBar(
                            context, "رمز عبور باید بیشتر از ۸ کاراکتر باشد");
                        return;
                      }
                      BlocProvider.of<LoginBloc>(context).add(LoginRequest(
                        email: _emailController.text.trim(),
                        pass: _passwordController.text.trim(),
                      ));
                    },
                    child: Text(
                      "ورود",
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
