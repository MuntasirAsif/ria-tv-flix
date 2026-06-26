import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/static/theme/src/theme_extensions/src/dimensions.dart';
import '../../../../../../core/static/theme/theme.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: const Dimensions().padding.p16.w),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Old Password",
                style: context.textStyle.headingSmall,
              ),
            ),
            5.verticalSpace,
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your current password",
                prefixIcon: Container(
                  padding: EdgeInsets.all(const Dimensions().padding.p4.r),
                  margin: EdgeInsets.all(const Dimensions().padding.p8.r),
                  decoration: BoxDecoration(
                    color: context.color.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outlined,
                    color: context.color.primary,
                  ),
                ),
                suffixIcon: const Icon(Icons.remove_red_eye_outlined),
              ),
            ),
            20.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Password",
                style: context.textStyle.headingSmall,
              ),
            ),
            5.verticalSpace,
            TextFormField(
              decoration: InputDecoration(
                hintText: "Enter your new password",
                prefixIcon: Container(
                  padding: EdgeInsets.all(const Dimensions().padding.p4.r),
                  margin: EdgeInsets.all(const Dimensions().padding.p8.r),
                  decoration: BoxDecoration(
                    color: context.color.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outlined,
                    color: context.color.primary,
                  ),
                ),
                suffixIcon: const Icon(Icons.remove_red_eye_outlined),  
              ),
            ),
            20.verticalSpace,
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Confirm Password",
                style: context.textStyle.headingSmall,
              ),
            ),
            5.verticalSpace,
            TextFormField(
              decoration: InputDecoration(
                hintText: "Confirm your new password",
                prefixIcon: Container(
                  padding: EdgeInsets.all(const Dimensions().padding.p4.r),
                  margin: EdgeInsets.all(const Dimensions().padding.p8.r),
                  decoration: BoxDecoration(
                    color: context.color.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outlined,
                    color: context.color.primary,
                  ),
                ),
                suffixIcon: const Icon(Icons.remove_red_eye_outlined),
              ),
            ),
            30.verticalSpace,
            FilledButton(onPressed: () {}, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
