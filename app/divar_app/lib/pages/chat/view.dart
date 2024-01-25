import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "به زودی...",
          style: TextStyle(fontSize: 14.sp),
        ),
      ),
    );
  }
}
