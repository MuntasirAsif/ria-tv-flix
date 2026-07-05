import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ria_tv_flix/core/gen/assets.gen.dart';

import '../../../../../../core/routes/route_const.dart';
import '../../../../../../core/static/theme/theme.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.padding.p16.r),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: Assets.images.appLogoCom.image(width: 300.w)),
                    10.verticalSpace,
                    Center(
                      child: Text(
                        'Welcome Back',
                        style: context.textStyle.headingLarge.copyWith(
                          color: context.color.primary,
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    Center(
                      child: Text(
                        'Enter your phone number to receive an OTP',
                        style: context.textStyle.bodyMedium,
                      ),
                    ),
                    20.verticalSpace,

                    // Form
                    const SignInForm(),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: context.textStyle.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () => context.push(RouteConst.signUp),
                          child: Text(
                            'Create Account',
                            style: context.textStyle.bodyMedium.copyWith(
                              color: context.color.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: context.color.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    20.verticalSpace,
                    // Center(
                    //   child: Text(
                    //     'or',
                    //     style: context.textStyle.bodyMedium,
                    //   ),
                    // ),
                    // 20.verticalSpace,

                    // google sign in button
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
