import 'package:divar_app/const.dart';
import 'package:divar_app/pages/profile/bloc/profile_bloc.dart';
import 'package:divar_app/pages/profile/bloc/profile_event.dart';
import 'package:divar_app/pages/profile/bloc/profile_state.dart';
import 'package:divar_app/pages/share_manager.dart';
import 'package:divar_app/pages/splash/splashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileRequestEvent()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          surfaceTintColor: Colors.white,
          foregroundColor: Colors.black,
          shadowColor: Colors.black,
          title: Text(
            "پروفایل",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 10.sp,
            ),
          ),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoadingState) {
              return Center(
                child: WidgetConstant.loadingAnimation(8.w),
              );
            }
            if (state is ProfileErrorState) {
              return Center(
                child: Text(
                  state.err,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              );
            }
            if (state is ProfileResponseState) {
              return Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                    child: CircleAvatar(
                      minRadius: 10.w,
                      maxRadius: 10.w,
                      backgroundColor: Colors.grey.shade300,
                      child: const Icon(
                        CupertinoIcons.person,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    state.userModel.userName,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text(
                    state.userModel.name,
                    style: TextStyle(
                      fontSize: 10.sp,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    onTap: () {},
                    trailing: const Icon(
                      CupertinoIcons.forward,
                    ),
                    title: Text(
                      "تنظیمات",
                      style: TextStyle(fontSize: 9.sp),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded),
                    onTap: () async {
                      bool isLogout = await ShareManager.logOut();
                      if (isLogout) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SplashScreen(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    trailing: const Icon(
                      CupertinoIcons.forward,
                    ),
                    title: Text(
                      "خروج",
                      style: TextStyle(fontSize: 9.sp),
                    ),
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
    );
  }
}
